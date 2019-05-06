Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B41AB146A5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 10:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfEFIoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 04:44:10 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48404 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfEFIoK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 04:44:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 61678607B9; Mon,  6 May 2019 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557132249;
        bh=ydlqwAabtpRijAjUSzqk2du8SudHZPyNeQNxRiXI6oI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=POQwK0Dtd5DZECB1lXcgrMsHasYHg/YMJjIBKINN8fT0n6PXAUhsCAo3Z06GvuNER
         GQxgxW/Wfap1sRGlIlPLRmFDyCz8O7iWROM767Z1h8afktoNcaTtxAaJSJ2ai/+2sx
         j/8tKa2H3Wo0TTa58PnmoFqfqBoPkvQ9HAJjnSJE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (37-136-65-53.rev.dnainternet.fi [37.136.65.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 261F960770;
        Mon,  6 May 2019 08:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557132248;
        bh=ydlqwAabtpRijAjUSzqk2du8SudHZPyNeQNxRiXI6oI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KWcUF1Z8OXc5YXBbnhPYaQpX16tZi50u2kugTB8d0r0Din6QWCcf/fE9TiD5BMhc9
         FjFhsN0n88E4Vy/g0yUPjZLe5SpLuDeP3CHYXjpkGMLTXeHS/X1nnbXdNU1j63ltQZ
         giFI9smVe/Yo9Ma3dNIE7XFn0NW5HTI4J0XrDQ0Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 261F960770
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Victor Bravo <1905@spmblk.com>
Cc:     Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
References: <20190504162633.ldrz2nqfocg55grb@localhost>
        <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
        <20190504194440.4zcxjrtj2aft3ka4@localhost>
        <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <20190505150355.3fbng4ny34x255vk@localhost>
Date:   Mon, 06 May 2019 11:44:02 +0300
In-Reply-To: <20190505150355.3fbng4ny34x255vk@localhost> (Victor Bravo's
        message of "Sun, 5 May 2019 17:03:55 +0200")
Message-ID: <87k1f4ug4t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Victor Bravo <1905@spmblk.com> writes:

> Sanitize DMI strings in brcmfmac driver to make resulting filenames
> contain only safe characters. This version replaces all non-printable
> characters incl. delete (0-31, 127-255), spaces and slashes with
> underscores.
>
> This change breaks backward compatibility, but adds control over strings
> passed to firmware loader and compatibility with CONFIG_EXTRA_FIRMWARE
> which doesn't support spaces in filenames.
>
> Changes from v1: don't revert fresh commit by someone else
>
> Signed-off-by: Victor Bravo <1905@spmblk.com>

The version should be in brackets "[PATCH RFC v2]" and the change log
after "---" line:

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

-- 
Kalle Valo
