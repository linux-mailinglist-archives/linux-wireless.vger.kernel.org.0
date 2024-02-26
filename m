Return-Path: <linux-wireless+bounces-4008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF9D867671
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 14:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3E71F23CA2
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Feb 2024 13:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36327127B61;
	Mon, 26 Feb 2024 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY0VbTBY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC986621
	for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 13:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708953976; cv=none; b=uW9U47WN6YMYfddoOtz4AX9P5Zv5GF/V1SZXEf20hfaBRf7WmbrMrJbDY7Ud05i/r7YhbKl6PmV3xMp8k19+4sbFSUI208601HVRybzic6Mp2y1X4Fr6C3BxDisZLAYqG/p0mjvRT285bOWJBplQdJyLBBp+cnJG3VEqEg/BrMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708953976; c=relaxed/simple;
	bh=tWT6trIgb8rEcrtzwcCWDYYDJW8UZXrdQX1VjiBCX0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TIBxg7sJWhPNy0KvEpWWwmP5VAt3XSOzuV3i+hEvcX6g3Akj1Wrmn2ejThtmddPrE1dd2dqyC+xEwsEtwtmeO1mJzwRn7ND+vZsLOHuKEikuE/pSbKwAoxhB+tilPB404mG7ih36Rrm1n6hBRJ+CqLz1NqYRtJ5W87WVSF4YDeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY0VbTBY; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2997cb49711so1256152a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Feb 2024 05:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708953974; x=1709558774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYKfVshOfe52yqjWflQIR7eGhngYLbjUT4X39sEk+Ow=;
        b=MY0VbTBYrzptyjaWDWAz8PycQ03YrBl2wGm5uVzM9Xf3TWQnHp4+HTeQ0YKXc7nme6
         zvx3K5YIMNB+vLJJdukbVOpHhQg8uLqWwt76koHd4GZXt0abUznEocttP5betx6azOVQ
         OYmUCkrjUVHey1u7qpJEhgLVvOhGiPfBuZDu9o0Q5lVqy/AVB6NQWuMF73zkkOLiVrmq
         Ira7YBOMjShnVMcDivPAuPsT/r2FJEQhc4hooFTJ2AMeZ8RjAb54dRVNdd22J2iME2fm
         mmxXwk37cDDdahpQmbmqxxnA+8mEnQTf9OyCsbRe1QwoniG78yGnbhVWW1BaiY1eEMcH
         gyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708953974; x=1709558774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYKfVshOfe52yqjWflQIR7eGhngYLbjUT4X39sEk+Ow=;
        b=qBB1+xjuxZKZJgidZLVVAHFbzcdDeMGLiuzBOWvZBHWcXjuyxG2y9B1+A5hIvRM3qB
         mjbciNfPA1xj5O1FKWRiXDfl5sG74+SfnsX+rKPkBA6GSWnUP7H04rLwLInOTTXGX8BN
         sMDOvM7P4isk1gWYgL0LJvVw/sEWueSNUaj8P+GqEl/cLl8fSBWjiDqhMyl48nA+Ec5/
         /+OhERtw+CIVkedi2dUrF4susJNaw0SL+W7zsB79rzU/nbjqW/txwcSxVEKcPwHVs59f
         qGVoYqYGuhyllr3FvN+vS91YETcxre/TUiBhPipIvui67mPbtKoA3575iOMsXJ/7Pl6S
         WYcw==
X-Gm-Message-State: AOJu0Yw0mS6VeENYNzzaciQuLNYNCIkt+0EeI63MNVAd9SFFd5qfblPS
	5Gt6a5gffbc5DNpBodMOPg2aFuOjzSTdidZd6fpUGwAAd2I15WG3AnTZeEhTblhM5ebPqVGUQeJ
	lQgJw19spY8T7zd320BkRHSWyltVulSgU1SE=
X-Google-Smtp-Source: AGHT+IGS+SLfyGLMMF6cqp7AaVh6bP2RnU+PyLUw+uYNzF4GdS2u148rehLfhhItRXF1wsB6oUHtwWYECA+FK1PnE1g=
X-Received: by 2002:a17:90a:b787:b0:29a:ac9d:a69d with SMTP id
 m7-20020a17090ab78700b0029aac9da69dmr3146467pjr.34.1708953973916; Mon, 26 Feb
 2024 05:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAMvbhFNBGF8h9z=ecVWQk4w+J7G7P=9vz5mh2KvpRNyx-3b2g@mail.gmail.com>
In-Reply-To: <CAAMvbhFNBGF8h9z=ecVWQk4w+J7G7P=9vz5mh2KvpRNyx-3b2g@mail.gmail.com>
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Mon, 26 Feb 2024 14:26:02 +0100
Message-ID: <CAFED-jk6bsjKpL7zQmXt2m2xni+fQQOPSyEMS=1+sGanozkj5A@mail.gmail.com>
Subject: Re: Intel BE200 Wifi 7 card.
To: James Dutton <james.dutton@gmail.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pon., 26 lut 2024 o 12:13 James Dutton <james.dutton@gmail.com> napisa=C5=
=82(a):
>
> Hi,
>
> I have seen lots of reports on the internet that say the Intel BE200
> does not work on AMD motherboards.
> So, by posting here I was hoping to find out if anyone knew whether it
> is a fundamental hardware incompatibility, or whether it is a bug in
> the software causing the problem.
> Intel's previous Wifi cards like the AX210 seem to work on both Intel
> and AMD motherboards
> , so maybe the BE200 is not supposed to work on AMD motherboards?
> I would be surprised as that probably cuts the BE200 off from about
> 50% of its market.
>

I have this card inside my banana PI R64 - ARM based:

root@bpi-r64-1:~# lspci -nn
0000:00:00.0 PCI bridge [0604]: MEDIATEK Corp. Device [14c3:3258]
0000:01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E
802.11ax PCI Express Wireless Network Adapter [14c3:7915]
0001:00:01.0 PCI bridge [0604]: MEDIATEK Corp. Device [14c3:3258]
0001:01:00.0 Network controller [0280]: Intel Corporation Device
[8086:272b] (rev 1a)
root@bpi-r64-1:~#
root@bpi-r64-1:~#
root@bpi-r64-1:~# uname -a
Linux bpi-r64-1 5.15.137 #0 SMP Tue Nov 14 13:38:11 2023 aarch64 GNU/Linux
root@bpi-r64-1:~#
root@bpi-r64-1:~#
root@bpi-r64-1:~# dmesg |grep iwl
[    8.512368] iwlwifi 0001:01:00.0: assign IRQ: got 149
[    8.517556] iwlwifi 0001:01:00.0: enabling device (0000 -> 0002)
[    8.523657] iwlwifi 0001:01:00.0: enabling bus mastering
[    8.559207] iwlwifi 0001:01:00.0: Detected crf-id 0x2001910, cnv-id
0x2001910 wfpm id 0x80000000
[    8.568086] iwlwifi 0001:01:00.0: PCI dev 272b/00f4, rev=3D0x472, rfid=
=3D0x112200
[    8.784501] iwlwifi 0001:01:00.0: api flags index 2 larger than
supported by driver
[    8.792276] iwlwifi 0001:01:00.0: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.9=
7.4.2
[    8.891945] iwlwifi 0001:01:00.0: loaded firmware version
83.d24e06ed.0 gl-c0-fm-c0-83.ucode op_mode iwlmvm
[    8.913864] iwlwifi 0001:01:00.0: Detected Intel(R) TBD Bz device, REV=
=3D0x472
[    8.956221] iwlwifi 0001:01:00.0: WRT: Invalid buffer destination
[    9.226787] iwlwifi 0001:01:00.0: loaded PNVM version e28bb9d7
[    9.340335] iwlwifi 0001:01:00.0: base HW address: a0:02:a5:d8:11:34
[406544.812198] iwlwifi 0001:01:00.0: WRT: Invalid buffer destination
[406545.164882] iwlwifi 0001:01:00.0: Registered PHC clock:
iwlwifi-PTP, with index: 0
[407167.666475] iwlwifi 0001:01:00.0: Unhandled alg: 0x707
root@bpi-r64-1:~#

Not sure then what it mean: "does not work on AMD motherboards." :)

BR
Janusz

