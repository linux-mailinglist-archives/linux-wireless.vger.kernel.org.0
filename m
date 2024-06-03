Return-Path: <linux-wireless+bounces-8438-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4178D8AD8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 22:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8189284A34
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 20:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22764D10A;
	Mon,  3 Jun 2024 20:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=carrierzone.com header.i=@carrierzone.com header.b="RJDwPawN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail33c25.carrierzone.com (mail33c25.carrierzone.com [64.29.147.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708114BAA6
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 20:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.29.147.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446093; cv=none; b=kd983XI96kbNTdxrxCV7PeRirSy7Q5/5dcgcoxCt3Fy+VC1iCsGO45hHlxi5hGNhclmLcToEyW1xA78BKa382BGZQ5FJwuUUiDJYxOIvQJ0DKeB6AFfYyEWfNAKUp6dxOoBeMc+Sjl4EmMZNf0Nf3R3niI3HC5OWzRuy6jEiflY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446093; c=relaxed/simple;
	bh=wYYoV7g0WvdZSAD+oWLLVWM6h9Ai7/dVs/nh+oAJmaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tz3Ou+I3ao4J3w+FXKCftixp0TuMlHdJTxYeISnQvfB3opX/QNtPlkJYiMY/xURhDPZq6T8DSBZkkBGERecRxqi1kZaLj0rwSuZbNlinHLPxHOZRz3VFQQjqyG85pl7TlHzpOBb7hlNhiQeuxUQ+3FrvrLxccgkJPpsbHgZ9tuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hindutool.com; spf=none smtp.mailfrom=hindutool.com; dkim=pass (1024-bit key) header.d=carrierzone.com header.i=@carrierzone.com header.b=RJDwPawN; arc=none smtp.client-ip=64.29.147.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hindutool.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hindutool.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=carrierzone.com;
	s=mailmia; t=1717446073;
	bh=wYYoV7g0WvdZSAD+oWLLVWM6h9Ai7/dVs/nh+oAJmaI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:Reply-to:From;
	b=RJDwPawNf2LtS1acNxk60/SQIAkdP+ER1Twlw8Q3k5SYrDpeSoyu2Tupe7R6RpLY1
	 jTclTDoSyilzpbnZ85hMJUG9xc2KBjPFFuOqH1k612OsQ4mR7bUiizKV5AcVS+tbmL
	 QO5j+T/SoGGK19IsnxC+AcKxdraIlb9WiufLUg5E=
Feedback-ID:pgupta@hindutoo
Received: from mail33c25.carrierzone.com (localhost [127.0.0.1])
	by mail33c25.carrierzone.com (8.14.9/8.13.1) with ESMTP id 453KL8Gm003940
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Jun 2024 20:21:09 +0000
Received: (from webmail@localhost)
	by mail33c25.carrierzone.com (8.14.9/8.12.2/Submit) id 453KL87I003939;
	Mon, 3 Jun 2024 16:21:08 -0400
From: "pgupta@hindutool.com" <pgupta@hindutool.com>
To: kvalo@kernel.org, quic_jjohnson@quicinc.com
CC: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: New staging repos for ath1*k firmware
Date: Mon, 03 Jun 2024 16:21:08 -0400
Message-ID: <1717446068.3fam2c8qo0gc0k0g@mailapp03.register.com>
In-Reply-To: <87ed9dn5va.fsf@kernel.org>
References: <bac97f31-4a70-4c4c-8179-4ede0b32f869@quicinc.com>
 <878r09gfzv.fsf@kernel.org> <87ed9dn5va.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Image-Url: https://mailapp03.register.com/api/storage/pgupta@hindutool.com/profile/picture
Reply-to: pgupta@hindutool.com
X-VADE-SPAMSTATE: clean
X-VADE-SPAMSCORE: 0
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffuvffqrffktedpqfgfvfdpgffpggdqvedvheenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkfgjfhggtgfgrhesthhqredttddtjeenucfhrhhomhepfdhpghhuphhtrgeshhhinhguuhhtohholhdrtghomhdfuceophhguhhpthgrsehhihhnughuthhoohhlrdgtohhmqeenucggtffrrghtthgvrhhnpeegteehhfeghfejtedvjeevhfehveefgffhtddujedvhffgheejudevhfevvdfgtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghdptghouggvlhhinhgrrhhordhorhhgnecukfhppeduvdejrddtrddtrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddphhgvlhhopehmrghilheffegtvdehrdgtrghrrhhivghriihonhgvrdgtohhmpdhmrghilhhfrhhomhepphhguhhpthgrsehhihhnughuthhoohhlrdgtohhmpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghthhduvdhksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghthhduudhksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthh!
 toheprghthhdutdhksehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepqhhuihgtpghjjhhohhhnshhonhesqhhuihgtihhntgdrtghomhdprhgtphhtthhopehkvhgrlhhosehkvghrnhgvlhdrohhrgh
X-Rspamd-Result: default: False [0.90 / 6.00];
	FROM_DN_EQ_ADDR(1.00)[];
	MIME_GOOD(-0.10)[text/plain];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	HAS_REPLYTO(0.00)[pgupta@hindutool.com];
	TO_DN_NONE(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Status: No, score=0.90
X-Origin-Country: Unknown

The manufacturer of my wifi7 modules (Compex) suggested I use the following=
 repository:

https://github.com/quic/upstream-wifi-fw/tree/main/ath12k-firmware/QCN9274/=
hw2.0/1.3/WLAN.WBE.1.3-03253-QCAHKSWPL_SILICONZ-1

Is this part of the ath12k project?  I have seen it online but have not use=
d it.=C2=A0=C2=A0

Prashant



On Mon, 03 Jun 2024 23:11:53 +0300, Kalle Valo <kvalo@kernel.org> wrote:

>> Kalle Valo writes:
>>
>> > Jeff Johnson writes:
>> >
>> >> Historically, prior to being incorporated into the linux-firmware
>> >> project, firmware for kernel.org ath1*k drivers has been first publis=
hed
>> >> to Kalle's GitHub:
>> >> https://github.com/kvalo/ath10k-firmware
>> >> https://github.com/kvalo/ath11k-firmware
>> >> (ath12k firmware was pushed to the ath11k-firmware repo on a temporar=
y
>> >> basis in anticipation of this move)
>> >>
>> >> But in order to have repos with multiple maintainers, as well as to h=
ave
>> >> a hosting platform with more control, we have moved to CodeLinaro:
>> >> https://git.codelinaro.org/clo/ath-firmware/ath10k-firmware
>> >> https://git.codelinaro.org/clo/ath-firmware/ath11k-firmware
>> >> https://git.codelinaro.org/clo/ath-firmware/ath12k-firmware
>> >>
>> >> Note that most people should not care about this -- normally you shou=
ld
>> >> use the firmware that is in the official linux-firmware repo:
>> >> https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware=
=2Egit/
>> >>
>> >> You should only need to access the staging repos if you need a previo=
us
>> >> version to work around an issue, or if you are testing new firmware t=
hat
>> >> is supposed to fix a problem that you've reported.
>> >>
>> >> Please let Kalle & I know if you have any issues with these new repos=
!
>> >
>> > The final reminder that the github.com repositories will be deleted in
>> > two weeks. If someone is still using them switch to the new
>> > git.codelinaro.org location NOW.
>>
>> And github.com repos are gone now.
>>
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp=
atches

