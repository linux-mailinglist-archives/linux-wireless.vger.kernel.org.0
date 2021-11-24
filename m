Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6EC45B7AF
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbhKXJr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 04:47:26 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:51352 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238060AbhKXJrY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 04:47:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1637747055; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=41o6sS1MLx/lIjXZseK5m7ONkaKla+cYhstE3GPbMAU=; b=tVPJuSJl8fWTuz5eSaMxfyBIGO5eTgKhu9WYUvhLm0NrgekTbl7u9R+xE2f8CnkEeYW/L1nj
 O0uxjX/iCPKMNr3v661ABoWd/u0JkDLqdGh0FOFKzYAyIVOYaBY2YBjT+dQiCUwhaiKPVHOc
 Je8si5rP/VFKA8EbDVJY108R5yM=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 619e096c1abc6f02d09ac385 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Nov 2021 09:44:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95904C4360C; Wed, 24 Nov 2021 09:44:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D936EC4338F;
        Wed, 24 Nov 2021 09:44:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org D936EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Mark Herbert <mark.herbert42@gmail.com>
Cc:     Wen Gong <quic_wgong@quicinc.com>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath11k: add read variant from SMBIOS for download board data
References: <20211118100033.8384-1-quic_wgong@quicinc.com>
        <163759171706.17469.3004620526954131593.kvalo@codeaurora.org>
        <f237c04d-6574-ec9a-ebca-65d2d9ff9edd@gmail.com>
        <871r3883q9.fsf@codeaurora.org>
Date:   Wed, 24 Nov 2021 11:44:09 +0200
In-Reply-To: <871r3883q9.fsf@codeaurora.org> (Kalle Valo's message of "Mon, 22
        Nov 2021 20:06:22 +0200")
Message-ID: <87fsrl6g7q.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Mark Herbert <mark.herbert42@gmail.com> writes:
>
>> Tried this on Dell XPS 13 9310
>>
>> Maybe this patch is good for 6855, but 6390 in Dell seems to be killed
>> completely with it. Reverting it makes things work again.
>>
>> [=C2=A0=C2=A0=C2=A0 5.537034] ath11k_pci 0000:72:00.0: chip_id 0x0 chip_=
family 0xb
>> board_id 0xff soc_id 0xffffffff
>> [=C2=A0=C2=A0=C2=A0 5.537038] ath11k_pci 0000:72:00.0: fw_version 0x101c=
06cc
>> fw_build_timestamp 2020-06-24 19:50 fw_build_id
>> [=C2=A0=C2=A0=C2=A0 5.537236] ath11k_pci 0000:72:00.0: failed to fetch b=
oard data for
>> bus=3Dpci,qmi-chip-id=3D0,qmi-board-id=3D255,variant=3DDE_1901 from
>> ath11k/QCA6390/hw2.0/board-2.bin
>> [=C2=A0=C2=A0=C2=A0 5.537255] ath11k_pci 0000:72:00.0: failed to fetch b=
oard-2.bin or
>> board.bin from QCA6390/hw2.0
>> [=C2=A0=C2=A0=C2=A0 5.537257] ath11k_pci 0000:72:00.0: qmi failed to fet=
ch board file: -2
>> [=C2=A0=C2=A0=C2=A0 5.537258] ath11k_pci 0000:72:00.0: failed to load bo=
ard data file: -2
>
> Doh, I didn't realise that. I only tested this on my NUC testbox, I
> should have tested this on my XPS 13 9310 as well. Thanks for the
> report!
>
> I think I need to revert this and rethink how to handle the backwards
> compatibility.

Revert sent:

https://patchwork.kernel.org/project/linux-wireless/patch/20211124094316.90=
96-1-kvalo@codeaurora.org/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
