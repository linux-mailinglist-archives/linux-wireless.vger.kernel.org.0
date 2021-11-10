Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1D44BBE3
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 07:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhKJHCj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 02:02:39 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:39902 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhKJHCi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 02:02:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636527591; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: References: In-Reply-To: Subject: Cc:
 To: From: Sender; bh=S/HSAFn7jaQ8H/1zmCelJn5XhhV3XFMa6E/Om1l9AsQ=; b=Q7AAIVyp8gLimBvC8By2lPPTXMCmvii00vEKNIBIXW8duj7lKpamZlgLmfSJWS9j6iVjpuHU
 8Nl9hViiMd3542s6UBskX+ABtm6a4VkbGJJxdPP6dNRd1phzOm1uispDRHXpXskCY6Ofgy5p
 B4LKMMKbj2QlWXm9AXTh2oPbk3c=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 618b6dd2332b6b6db4e0c1cf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Nov 2021 06:59:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 67906C4360C; Wed, 10 Nov 2021 06:59:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 926FEC4338F;
        Wed, 10 Nov 2021 06:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 926FEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?Q?Stanis=C5=82aw?= Gruszka <stf_xl@wp.pl>
Cc:     Exuvo <exuvo@exuvo.se>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Helmut Schaa <helmut.schaa@googlemail.com>,
        "regressions\@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: rt2x00 regression
In-Reply-To: <cc85b4e8a038417b865069c6578acf50@grupawp.pl> (=?utf-8?Q?=22S?=
 =?utf-8?Q?tanis=C5=82aw?=
        Gruszka"'s message of "Tue, 09 Nov 2021 18:36:08 +0100")
References: <ca+gwt0b5syrznglqwqoeujk4cwmvc=dkawre9vn8kqc6kbzkgw@mail.gmail.com>
        <20191203075736.ga701@redhat.com>
        <d74dab51-3a84-9035-d89e-ea8f63e89198@exuvo.se>
        <a8eeb0bc-95da-291a-7fb9-5d15d1174c27@exuvo.se>
        <c22673af-40e0-3af2-5ab7-69b23fc03598@exuvo.se>
        <f935dc15-08bd-2e28-fc1b-b27634c618be@exuvo.se>
        <87czop5j33.fsf@tynnyri.adurom.net>
        <6366d9bd-9752-dbc2-8970-442bdc6e8eea@leemhuis.info>
        <7d353dd2-2ffb-6d5e-9983-f983c8b4f6da@leemhuis.info>
        <20211109073127.ga109212@wp.pl> <20211109120737.ga120005@wp.pl>
        <c81f829d-fd87-7580-fb9a-1a84958f890f@exuvo.se>
        <cc85b4e8a038417b865069c6578acf50@grupawp.pl>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Wed, 10 Nov 2021 08:59:22 +0200
Message-ID: <87wnlgo5rp.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanis=C5=82aw Gruszka <stf_xl@wp.pl> writes:

> Dnia 9 listopada 2021 16:22 Exuvo <exuvo@exuvo.se> napisa=C5=82(a):
>
>  Just tested it and it passes the rt2x00lib_load_firmware but still error=
s on
>  rt2800usb_set_device_state:
>
> <snip>
>
>  @@ -30,7 +30,8 @@ static bool rt2x00usb_check_usb_error(struct rt2x00_de=
v *rt2x00dev, int status)
>    else
>    rt2x00dev->num_proto_errs =3D 0;
>=20=20=20
>  - if (rt2x00dev->num_proto_errs > 3)
>  + if (rt2x00dev->num_proto_errs > 3 &&
>  +    !test_bit(DEVICE_STATE_STARTED, &rt2x00dev->flags))
>    return true;
>=20=20=20
>    return false;
>
> Sorry, I screwed logic in my patch. It should be test_bit() instead of !t=
est_bit().=20
> And also we should not count when device did not start. So patch should b=
e somewhat different. I'll
> send tomorrow hopefully better patch.=20

No HTML, please :) I'll reply so that lists see your email.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
