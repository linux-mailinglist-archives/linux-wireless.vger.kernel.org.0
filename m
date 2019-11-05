Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5455CEFF6B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 15:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbfKEOHD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 09:07:03 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:55822 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389464AbfKEOHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 09:07:03 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E8E8261820; Tue,  5 Nov 2019 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572962822;
        bh=5eK7eD8/aVzx8DFNzSBXyfMRRhc9q3D7JteLV+ayqgw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=Jd0lb1oCgUlnGCpyWErcRKLjfWWSPqJ9fOWXLq1BEt4F9TYkpf8D/S84Omhnecn/X
         o3N9X9omMfTy4LNZxiZd15NqD2q2P8NhI2WBVsnWbArBDRSX3dsyrrkib8NN4+JLCL
         3bn3BtdpBfR+/0GiRm5pPJGx7a4LcuAR8dDGDeLs=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5A10C61817;
        Tue,  5 Nov 2019 14:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572962819;
        bh=5eK7eD8/aVzx8DFNzSBXyfMRRhc9q3D7JteLV+ayqgw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OqLTZIHPCqtMPeBQrZIYpRJRwbLUPzL1Cm0klIUcmyLUmMobyDmtzYlfNRyVLOyvL
         SefqPWiCfx4ogxXOek+LJs7GIITriRcEFjM4tEI2C7J8siItEF58233xFw6OkGdnTd
         TIPK5baOlRjnA+hgSeW3knla/K0KuPIwkG1jW73A=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5A10C61817
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Stanislaw Gruszka <sgruszka@redhat.com>
Cc:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>,
        linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: Re: [PATCH] Revert "mt76: mt76x0e: don't use hw encryption for MT7630E"
References: <1572860780-2403-1-git-send-email-sgruszka@redhat.com>
        <87eeymd98m.fsf@tynnyri.adurom.net> <20191105090043.GB4422@redhat.com>
        <20191105090845.GP22393@meh.true.cz>
        <20191105095226.GC4422@redhat.com>
Date:   Tue, 05 Nov 2019 16:06:54 +0200
In-Reply-To: <20191105095226.GC4422@redhat.com> (Stanislaw Gruszka's message
        of "Tue, 5 Nov 2019 10:52:27 +0100")
Message-ID: <875zjy76yp.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <sgruszka@redhat.com> writes:

> On Tue, Nov 05, 2019 at 10:08:45AM +0100, Petr =C5=A0tetiar wrote:
>> Stanislaw Gruszka <sgruszka@redhat.com> [2019-11-05 10:00:44]:
>>=20
>> Hi,
>>=20
>> > I provided the topic in the first reference of the commit at the top.
>> > Should I do this anytime in the chenglog when a commit is referenced,
>> > even if it's done already ?
>>=20
>>  ./scripts/checkpatch.pl
>> 0001-Revert-mt76-mt76x0e-don-t-use-hw-encryption-for-MT76.patch
>>  ERROR: Please use git commit description style 'commit <12+ chars
>> of sha1> ("<title line>")' - ie: 'commit 7bd0650be63c ("mt76: dma:
>> fix buffer unmap with non-linear skbs")'
>>  #8:=20
>>  Since 7bd0650be63c ("mt76: dma: fix buffer unmap with non-linear skbs")
>
> Okay, so I should add word 'commit' before HASH.
>
>>  ERROR: Please use git commit description style 'commit <12+ chars
>> of sha1> ("<title line>")' - ie: 'commit 7bd0650be63c ("mt76: dma:
>> fix buffer unmap with non-linear skbs")'
>>  #14:=20
>>  fixed by 7bd0650be63c , we can enable HW encryption back.
>
> It's not clear if topic is need, but I can change it on the way.
> BTW I hate checkpath.pl .

checkpatch gives only hints, it's perfectly ok to ignore warnings which
don't make sense. So no need to change anything in this case as you have
provided the title already earlier in the commit log.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
