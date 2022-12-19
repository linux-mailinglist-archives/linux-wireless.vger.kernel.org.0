Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBAF6516AC
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Dec 2022 00:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiLSXPu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 18:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbiLSXPV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 18:15:21 -0500
Received: from hannover.ccc.de (ep.leitstelle511.net [80.147.51.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590F1B9F5
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 15:07:28 -0800 (PST)
Date:   Tue, 20 Dec 2022 00:06:57 +0100
From:   ingo@hannover.ccc.de
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [bug report] rtw88 / 8821cu driver missing firmware
Message-ID: <20221219230657.GA29752@hannover.ccc.de>
References: <Y6Bnc+UUY3R/nc6L@spatz.zoo>
 <8b86edab-5bd6-cab0-f8f8-f5c6bc757988@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b86edab-5bd6-cab0-f8f8-f5c6bc757988@lwfinger.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 19, 2022 at 04:53:23PM -0600, Larry Finger wrote:
> The firmware that is needed is the same as for the PCIe nersion,
> namely /lib/firmware/rtw88/rtw8821c_fw.bin. Your distro should have
> that firmware in package firmware-realtek, or in
> linux-firmware-realtek. If they do not, you can get it by 'git clone git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git.
> The firware will be in directory rtw88.

That file is installed on my system, yet I get the above error messages.

$ ls -l /lib/firmware/rtw88/rtw8821c_fw.bin
-rw-r--r-- 1 root root 139472 Dec 16 17:54 /lib/firmware/rtw88/rtw8821c_fw.bin
$ sha1sum /lib/firmware/rtw88/rtw8821c_fw.bin
69c087a1963953c2e0e8a8338237e0689b4d7c40  /lib/firmware/rtw88/rtw8821c_fw.bin

So something else must be broken. I'll try the rtw88 driver from ulli
krolls git repository later.

    Ingo
-- 
 ╭─╮  Kennedy's Lemma:
╭│───╮  If you can parse Perl, you can solve the Halting Problem.
│╰─│─╯
╰──╯  http://www.perlmonks.org/?node_id=663393
