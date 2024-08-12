Return-Path: <linux-wireless+bounces-11312-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A35C394EECA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 15:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6562D282442
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A27C1836E2;
	Mon, 12 Aug 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8IUVvFK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DED17BB11
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470684; cv=none; b=KRbinGvcx9d06so+j9y7UpyrJ38H3oa5snyCaLS/+4w/wEURkGeySdjhs36pdOLS986N9PXH/l0Az3Z/HnwyGQ/QPzOYzG1l3dasyOTW+Wqpat83lPsVKp/2GuDEdcIQ7DYEYNxWY95bCq+OACl2rcsRtVXBIWc/jouqR7bqw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470684; c=relaxed/simple;
	bh=M9XmR40yrAsZitl3Ss77i42V2mDg8K8PPxjlunZWUYU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lQaQuj/dYMuW4gs3wNRQn7P19GzCJa2fJ25TxedJTOadsx7FRt1HqQC714YaSIeaSEQakWifeYuAzPPcWUdb4o3pOOZ+JRFP+MskCEo65tfE5eMkWYDSb5v5xOj7da+abIC8h74lp22/nAIsCedGC8yu5YuNZ/AWPdS3gMHhOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8IUVvFK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280b3a7efaso32520585e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 06:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723470681; x=1724075481; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv96XB4gZxCxlU1SRHBLRK7/Tf/KJItVDb5kLcxytxc=;
        b=f8IUVvFKDb5zNJeF7XFGMzp1Qhq7n9rZlD7Bnx24HU/yca2vBegfyINa9kVJDHK3am
         tjA+SzykBTxNZHHtHqyqIwZwa7iqaL13zx52rKotvv1mzVShQRIy9I0VdOmu2/YdwhmZ
         e+jj/jTZEjKplyJgiqZ5aELFOxbzWfNNWml6Rk2KxXakBCNvhQVc12kMG7nUkq8xAryu
         LPeWieMjUpZ1dmbx5yCYasaMOghOvUdD71jQlYi9G4XAMqHNqUeTazC22kP/iCHWmBue
         9WHd6dRgMSWAxKpyjqhJ6deY3Z7LU4fodRpkH+kY+6H7PcmZe6EoD/ZhoGh1vUKC78+n
         JipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723470681; x=1724075481;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sv96XB4gZxCxlU1SRHBLRK7/Tf/KJItVDb5kLcxytxc=;
        b=GVXUemzDZZ54anYJpLy88bJmT2dQ8ueKmFBd41ALEHUmByDTjLDMROSl2FT6tfFY23
         apmnWnAj9cvoBj1hrd5yRfDwiC6Rx/xU7g9ZlPJSVrfaIWNzFlwWFDHwg8EzwNbzt+me
         X73ZxBJep8+tc4G3Np3koWHM6/9oZ7IlRS1r2TR3r+rVi/WM5h8oulH9vr1gkp7hQXEe
         t5mmYtWW+/autnZzRpoFjgJsFTgmVPDR+v1wHFSmFCTbsjT5hVzwvQrD4iycLj/c3qub
         PxcEieDnJLMS7GayPQI/XSlHHne0U7S98Pll+C1F/2bGke/PsC3IdCpn/gyloxJmYBVK
         jZCQ==
X-Gm-Message-State: AOJu0YwLZ0IvWJi7elDUg6/1zEbA7a5RXZ7yHojG7Ieuew5ddteZbpqv
	MILy8r+C46f4AWsmnfunRGCwnYhf1pBDzYVL74/q/Qp9SL+Qqr2i
X-Google-Smtp-Source: AGHT+IGT5u1NqSmVw0khE+rObz5Dg6ToYQAWxdK+XuqNfbiah4Ndgm9Eh0u5p4ztbQyuH0eo20TEng==
X-Received: by 2002:a05:600c:4f0d:b0:425:69b7:3361 with SMTP id 5b1f17b1804b1-429d48188bemr4324935e9.18.1723470680629;
        Mon, 12 Aug 2024 06:51:20 -0700 (PDT)
Received: from smtpclient.apple ([169.224.80.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c74a855sm188663005e9.25.2024.08.12.06.51.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2024 06:51:20 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [question] is it possible to enable monitor mode /packet
 injection on wcn3990
From: MOHAMMAD RASIM <mohammad.rasim96@gmail.com>
In-Reply-To: <87zfpigr5t.fsf@kernel.org>
Date: Mon, 12 Aug 2024 16:51:07 +0300
Cc: linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D802221D-56B0-4CBB-833A-EA548A36FC7E@gmail.com>
References: <CACq04CG8WCGDxf6Krx3bjxHU5OtYJJNOtD77TtPQhTfdy6ey_g@mail.gmail.com>
 <56BBE89F-FF40-47C4-A4B9-F492FD8F6E2A@gmail.com> <87zfpigr5t.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On 12 Aug 2024, at 10:02=E2=80=AFAM, Kalle Valo <kvalo@kernel.org> =
wrote:
>=20
> + ath10k list
>=20
>> I have a device that has the wcn3990 wifi chip that uses the
>> ath10k_snoc driver, i tried to put it in monitor mode, the "set
>> monitor" mode command succeed but can't get any scanning working =
after
>> that, does the chip support such mode?has anyone tried monitor mode
>> with this chip or other snoc chips?
>=20
> I doubt that WCN3990 firmware supports monitor mode, though just
> guessing here.
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> =
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpat=
ches

Some people has got monitor mode working under android ( different =
driver, qcacld-2.0, and qcacld-3.0) with these kind of chips: =
https://github.com/kimocoder/qualcomm_android_monitor_mode/


Some older chips (wcn3680  think) even supported packet injection(using =
the older  qcacld-2.0 driver).

Commits in the newer  qcacld-3.0 driver (that supported the wcn3990) did =
contain hints that monitor mode and packet injection should work.

So maybe the firmware does support it?

Regards=

