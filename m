Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A943613B32
	for <lists+linux-wireless@lfdr.de>; Sat,  4 May 2019 18:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfEDQdD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 May 2019 12:33:03 -0400
Received: from 0.ictbs.com ([203.137.112.168]:43172 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfEDQdD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 May 2019 12:33:03 -0400
X-Greylist: delayed 382 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 May 2019 12:33:02 EDT
Received: by hq.local (Postfix, from userid 1000)
        id 0754F66477; Sat,  4 May 2019 18:26:33 +0200 (CEST)
Date:   Sat, 4 May 2019 18:26:33 +0200
From:   Victor Bravo <1905@spmblk.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: PROBLEM: brcmfmac's DMI-based fw file names break built-in fw loader
Message-ID: <20190504162633.ldrz2nqfocg55grb@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The brcmfmac driver seems to have partially fixed problems which
prevented it to be used in shared system/kernel images for multiple
hardware by trying to load it's <config>.txt as
<config>.<dmi_sys_vendor>.<dmi_product_name>.txt first and then
falling back to <config>.txt. Real-life example:

brcmfmac mmc1:0001:1: Direct firmware load for brcm/brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt failed with
error -2
brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43340-sdio for chip
BCM43340/2

Unfortunately this doesn't really help on systems which use static
kernel with firmware blobs (and also text configuration files in case of
brcmfmac) built-in using CONFIG_EXTRA_FIRMWARE, as CONFIG_EXTRA_FIRMWARE
doesn't support spaces in file names - kernel build fails with

CONFIG_EXTRA_FIRMWARE="brcm/brcmfmac43340-sdio.bin brcm/brcmfmac43340-sdio.ASUSTeK COMPUTER INC.-T100HAN.txt"

for obvious reasons. So the only way here is to stay with good old
brcmfmac43340-sdio.txt and support at most one brcmfmac-equipped machine
per kernel image.

Please consider filtering the DMI strings and replacing spaces and
possibly other invalid characters with underscores, and/or adding module
parameter to allow passing the string from command line (using
brcmfmac.tag=t100 or brcmfmac.board=t100 to make the module load
brcmfmac43340-sdio.t100.txt seems nicer to me, and isn't prone to
breaking when DMI strings change on BIOS update).

My brief grep-based research also suggest that strings retrieved
by dmi_get_system_info() are passed to firmware loader without any
checks for special character, /../ etc. I'm not sure whether this is
considered to be proper & safe use, but if it's not, it may also have
some security implications, as it allows attacker with access to DMI
strings (using root rights/other OS/BIOS/physical access) to mess
with kernel space or secure boot.

I would also really appreciate not allowing future brcm (and other)
drivers to leave staging area before they fully support =y.

Regards,
v.b.
