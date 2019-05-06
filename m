Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C26D414986
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2019 14:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfEFM0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 May 2019 08:26:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:56716 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFM0f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 May 2019 08:26:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 806FF60A44; Mon,  6 May 2019 12:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557145594;
        bh=mjz5y1YF37BWba0/Yf7ZhLw5CnmxhMPjN802sVr7vdg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Or9Q36x1FeTpHbWu3Ld28q89P55CwOHkCDs1rDZ14ldfdwqCQgRpSbyh8W2q0Y0E5
         2vdqcoYZG6fzkRWZGSssr7+e5hlUIsipW2hhORP+bnJrNpqm0QCc/wrrz/Nm7vppcP
         B1TvpPtrclutmNUuQNfW5r8C5fm2T4EB6PkbZWK8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (85-76-75-57-nat.elisa-mobile.fi [85.76.75.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4FD4560590;
        Mon,  6 May 2019 12:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557145593;
        bh=mjz5y1YF37BWba0/Yf7ZhLw5CnmxhMPjN802sVr7vdg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=oWhz0ypyIvO8lOLmqXuQCAr3zqDj67mpRw2qEng2XilGn9DVvn04zuM3LDkbC43YP
         +Yaicj+MrP5txKLnkXmQA9f1Z1RiTlA8AG13k2ied7KS7ws/79o6cIlcgFykLfU0ir
         1TSK5TZSslbk8QGol11Bv3k9xIfmHt0WsPd9Y7ZU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FD4560590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Victor Bravo <1905@spmblk.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings v2
References: <20190504162633.ldrz2nqfocg55grb@localhost>
        <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
        <20190504194440.4zcxjrtj2aft3ka4@localhost>
        <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
        <20190505150355.3fbng4ny34x255vk@localhost>
        <0f75a3d4-94af-5503-94c3-e8af2364448d@redhat.com>
        <20190506090609.msudhncj7e5vdtzw@localhost>
        <70677dff-4336-28d5-7ab9-7ba7c3d74ebc@redhat.com>
        <20190506102032.3ximjecado4mz62j@localhost>
        <fb07ae01-4cca-98e7-1c2d-dfdf44909900@redhat.com>
Date:   Mon, 06 May 2019 15:26:28 +0300
In-Reply-To: <fb07ae01-4cca-98e7-1c2d-dfdf44909900@redhat.com> (Hans de
        Goede's message of "Mon, 6 May 2019 12:34:17 +0200")
Message-ID: <87d0kvvkej.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hans de Goede <hdegoede@redhat.com> writes:

> If we're going to do some filtering, then I suggest we play it safe and also
> disallow other chars which may be used as a separator somewhere, specifically
> ':' and ','.
>
> Currently upstream linux-firmware has these files which rely on the DMI
> matching:
>
> brcmfmac4330-sdio.Prowise-PT301.txt
> brcmfmac43430-sdio.Hampoo-D2D3_Vi8A1.txt
> brcmfmac43430a0-sdio.ONDA-V80 PLUS.txt
>
> The others are either part of the DMI override table for devices with unsuitable
> DMI strings like "Default String"; or are device-tree based.
>
> So as long as we don't break those 3 (or break the ONDA one but get a symlink
> in place) we can sanitize a bit more then just non-printable and '/'.
>
> Kalle, Arend, what is your opinion on this?
>
> Note I do not expect the ONDA V80 Plus to have a lot of Linux users,
> but it definitely has some.

To me having spaces in filenames is a bad idea, but on the other hand we
do have the "don't break existing setups" rule, so it's not so simple. I
vote for not allowing spaces, I think that's the best for the long run,
but don't know what Arend thinks.

Maybe we could do some kind of fallback mechanism, like first trying the
sanitised filename and if that's not found then we try the old filename
with spaces? And if that old filename works we print a big fat warning
that the user should update the file and that the old "filename with
spaces" support is going away soon?

-- 
Kalle Valo
