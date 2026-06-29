Return-Path: <linux-wireless+bounces-38307-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MOmHKsO3Qmp1AAoAu9opvQ
	(envelope-from <linux-wireless+bounces-38307-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 20:21:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E796DDF9E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 20:21:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PdQZiBh6;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38307-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38307-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 98D543006449
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2026 18:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D7C383318;
	Mon, 29 Jun 2026 18:21:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7535838F
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 18:21:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782757310; cv=none; b=BZXFDO64rFA56eqd6WFXCdWMO5x391LZSOXwHwYr8KlZT9d8DS4L2A5l1g0B8n1Q/N4pTt0/VOcJ4yEY9YCdy2brFpihIKuqy6vx3jA1mDAm28FSrCQbA/olRGIV1e9KzyLndDR4XgHzAZOOKQiIXzI6V9lkN8j0We7dz/2k4aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782757310; c=relaxed/simple;
	bh=uVJE7agHkpN36kqdcRJ3f1sEnJQPMFcd6wB57yBRWMo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bj+DVMzqHFN69UdT5c2PVKRAV2sL41iNpxVO6kJPAS2N5rQrMyu+2+Z8bLMYNXnR6ahupxhansjcGQrxcRklNhAv+UUhmq6Mn83xO8JCuZSIEq4N4T2Cb5d2y7L9AyFrylzVtsw5rLOikjDE9DWQTozK3gSrbq1xhhcI7w705Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PdQZiBh6; arc=none smtp.client-ip=209.85.219.42
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8de4dd10a61so34584846d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 29 Jun 2026 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782757307; x=1783362107; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVJE7agHkpN36kqdcRJ3f1sEnJQPMFcd6wB57yBRWMo=;
        b=PdQZiBh6ui9otYJCXr6z3F+ItFCMd58x1mcRjhHc8Q8YnqaQj5Ok7hrWKFJheddJXF
         J/6zu82NNjYbOCJDX6MLqwXzvLLgd7UVFH/mwOZ9qZcnr1f9s3ryXN7sW0ginutVTh+Q
         ln9v+HW7Sh0h0OdRxniVzPnmMn7FP3QY84qBwgX5WxQ6C0juug1pIgvi3UzlIPWmQq0U
         1s1BbvFN5SpJSUCixdqgP2PataAv8tj/mRloVIhJ8dEJuWVFgoSkkWGQmoRHqCg2DGeA
         pR7FAoi9Ac5/QEp1xlz+wMK16wnpgLg2t76d/wKn/rWSHKubdN0AUjbhCn/KWDiHRMTx
         drow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782757307; x=1783362107;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uVJE7agHkpN36kqdcRJ3f1sEnJQPMFcd6wB57yBRWMo=;
        b=Qmt3GuZG232Ip9rDL7kxCzHIkSiNAhea0pExs/5wdAtjGbHwZVIpsfvJRLDR5I16gv
         OaCShZj7nQS0je3go3BovTv4ccW8Vz+WrH2p6+8Djl9rmdI6Ws0SIcSg0hsHh1AWxafe
         baZYpV9tVJTtUOB61QZ/St53YW31D+aWon1gan/AxRMgUKdHZY6evVXTZddRpi15v9dB
         3m+ZKrg0x4c1t1KAe96W17M4yKgVx62zigcTuP9cAkGKmIU5T0tyMRmQvvOVw6kNuYlO
         y/BYWOtg8P/GxE0pf/aZ5X/9efdsswr8JFIW0/X/kRj7euyBCyEtO2sOCQKOp3zSRv9T
         8/ug==
X-Forwarded-Encrypted: i=1; AHgh+RrgYNV0ZB6+ZCOLHMNqK8AcB39H3FhrMC//ACGx+Saog2lX6jaxEFxOlzZcuhGfW03iudmpnFcysyrlf9KT0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh4IqIizLtibwKGqVafTWdLU0jLr/3oTK/P4YVVaFZ8C8uvF7g
	cm3+KWH/prPnG9Ge8HzbP1a5/c7btq8xR7RVssif275p7SajihK0F/rx
X-Gm-Gg: AfdE7clMW1pY6LCYVf7eXjUC9QM3tvWN7U/4v6KqTGgyqjTdLELr9c82H9kINN4QE79
	M//4YxxVbeLxGHeyUaoavKx8KoSC7TXX+HmXHgAJ4kx/lK02Yd/7b4a4lm0+82yI4bOnhrqbBgg
	/7di+gQSExEwskFq0X7iGTS3paNKoowz0AQv8VZDFLElpzL6vB7M89CmKSiW6B8jEYGMw+afhhZ
	rHJhyyWT02VmzsVrDZdGj9XZq6823VJUIAi889Uy65boAh3VeVLrDLSxu/BjawXTaxl9sXiVPot
	CYz4CMkFhhPOe5d1DPuRHS/jLi335TQgPpnxYVOcrrR/PzvUtHWj8kF/Qa3KYWu/vrkSaT3pYZ0
	znQfM6kzkEXpHDmnYR4vbeHSooGYyJW1/6EZcAFBCcchsh4VW7EV5MCfNIiPOWvwlaIc2+dJDEU
	cOWWq4lfNXgFzNbDBnnj1gvXSblOftIEk=
X-Received: by 2002:a05:6214:84ce:b0:8e9:f62b:bee4 with SMTP id 6a1803df08f44-8f1bc39795emr6357056d6.52.1782757306440;
        Mon, 29 Jun 2026 11:21:46 -0700 (PDT)
Received: from smtpclient.apple ([2601:19b:4200:392f::192])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a338c6easm4349756d6.17.2026.06.29.11.21.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2026 11:21:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH 1/1] wifi: ath12k: support calibration-variant from device
 tree
From: Andrew LaMarche <andrewjlamarche@gmail.com>
In-Reply-To: <rh6uz6bqetobowyrist7hhytdu32v2azvuambenyzofur3tjyj@wghfgwtmjj53>
Date: Mon, 29 Jun 2026 14:21:35 -0400
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jeff Johnson <jjohnson@kernel.org>,
 linux-wireless@vger.kernel.org,
 ath12k@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <78CFA317-FE31-46EC-8AF7-D2BA989D8B0B@gmail.com>
References: <20260131003222.2011259-1-andrewjlamarche@gmail.com>
 <A2E3AAE1-1A80-4265-9497-0C95C3308CD7@gmail.com>
 <dc8c9c9c-dc85-40dd-9313-845a808a35f4@oss.qualcomm.com>
 <3B9D1FBE-37D0-4902-8C0C-8AB57C1310A5@gmail.com>
 <23fr45actdrqt6rp6fozcaugyk3egs5zm7imschl7gyuuj6cme@3pvdhqv7xvkq>
 <rh6uz6bqetobowyrist7hhytdu32v2azvuambenyzofur3tjyj@wghfgwtmjj53>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:jeff.johnson@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:ernestvanhoecke@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38307-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrewjlamarche@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39E796DDF9E

I will prepare v2 this week.

> On Jun 29, 2026, at 4:21=E2=80=AFAM, Ernest Van Hoecke =
<ernestvanhoecke@gmail.com> wrote:
>=20
> On Mon, Jun 15, 2026 at 03:36:50PM +0200, Ernest Van Hoecke wrote:
>> On Wed, May 27, 2026 at 05:01:51PM -0400, Andrew LaMarche wrote:
>>> Ack on the deprecation of qcom,ath12k-calibration-variant in favor =
of the
>>> generic qcom,calibration-variant.=20
>>>=20
>>> However, drivers/net/wireless/ath/ath12k/core.c still misses the =
logic to=20
>>> actually load in the BDF, which this patch also accomplishes. I =
don=E2=80=99t see that
>>> in the Qualcomm-authored series you linked. Perhaps a v2 to address =
this?
>>>=20
>>> Andrew
>>>=20
>>>> On May 27, 2026, at 3:52=E2=80=AFPM, Jeff Johnson =
<jeff.johnson@oss.qualcomm.com> wrote:
>>>>=20
>>>> On 5/27/2026 9:12 AM, Andrew LaMarche wrote:
>>>>> Hi,
>>>>>=20
>>>>> A kind ping here. I=E2=80=99m not sure why this functionality is =
missing in the first place, but it is needed for loading caldata from =
the device tree.
>>>>=20
>>>> Your patch duplicates functionality in the Qualcomm authored =
series:
>>>> =
https://msgid.link/20250228184214.337119-1-quic_rajkbhag@quicinc.com
>>>>=20
>>>> And note the upstream device bindings for ath10k and ath11k only =
support the
>>>> generic binding qcom,calibration-variant.
>>>>=20
>>>> There are no longer any generation-specific bindings, see:
>>>> =
https://msgid.link/20250225-b-wifi-qcom-calibration-variant-v1-0-3b2aa3f89=
c53@linaro.org
>>>>=20
>>>> /jeff
>>>=20
>>=20
>> Hi Jeff,
>> Hi Andrew,
>>=20
>> We also need this functionality, and as Andrew noted, the patch =
series
>> from Qualcomm does not actually address this.
>>=20
>> I believe some confusion arose because the patch series mentions the
>> "qcom,calibration-variant" DT property, but it does nothing to =
implement
>> this in the driver. In that series it only exists within a schema =
file:
>> Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
>>=20
>> Our need for this property was previously discussed here, and for now =
I
>> don't see a way forward without it:
>> =
https://lore.kernel.org/all/77vowy4ax4cl6dlc45i2q3fjmwn3q676wqghq267tmbix7=
773b@27h5t66mflur/
>>=20
>> Thanks a lot for your work here.
>>=20
>> Best regards,
>> Ernest
>>=20
>=20
> Hi Andrew,
>=20
> Are you planning to send a v2 of this?
>=20
> If not, I'm considering sending a version of this with the
> qcom,calibration-variant binding to move this forward.
>=20
> Thanks for your work here!
>=20
> Kind regards,
> Ernest
>=20


