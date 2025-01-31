Return-Path: <linux-wireless+bounces-18243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65D5A23ADF
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23DB3A4C2B
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2025 08:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8B13A3ED;
	Fri, 31 Jan 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUIYWQO9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2485260
	for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738313528; cv=none; b=TpPsHW3LWg7L8CiQo2EcdXqjxxEBSPh+iPRsB97xj9QliZs10a5hqy4q+5/hSg5RDxDW0aw6ks+dIUh0IWAUr4GFGQCThCfY5XdbQ7XtJeYTLynPtjOD+C4um+kp2QOsTtEFTJFpQ8y3tRzK30fzTbaImAojyA1fLEGVA/qjFvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738313528; c=relaxed/simple;
	bh=5XUaYe+DDbX409EqAP1ALBbjcjSsJrUVzYWYdEICY40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=OoSFaGHJRUVIGZQSQE4bs4iPAq800THAQNZjDe/6GG5e/QD6w6IAqLmTpdMiVSk45KBZMr6vJpoFANgdMolhwJCESP7BbWknJsMYLpq+sMf9m+Ex7o72Y8V+sRmoDONqQI1QVvD4qtuXSLikr/Aq5jcbZMdEXVs2DqYqg9o1Yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUIYWQO9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2efded08c79so2349989a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 31 Jan 2025 00:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738313525; x=1738918325; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DYxIxldY+18YpSOIneCSFlLcsvrWAvqtkKk/kyK0f8=;
        b=HUIYWQO9VklmG4SkBs9/hu1VIYVMCfpNSmpizryxLiD7ujZfLog9LX2OxbAKLoU0pI
         yrMem9mxCJdZScqzupOZXYykA7lE1nmsy1fuslnxSp3Fq8jLgfvYMYO8mkAptNxnOtCx
         8vRi4v+dXLv1dl4oXxpRSxaMvlfjda+g1x3k/06G15UH+UAX7aBemh7OuD2hDc0kWyVn
         FPllowKY6b6/9pr68MemitoQ9lRTSvbLh890zdBwNyQ54oEA4YroC3tx8EOQSZaxXn1E
         +TwZ/5Wj1j2hra1edUF+2W/MJIsqZQVv0ndeyKAmMji6umHmVX+6lkNVKdmYVY1yvBFB
         JlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738313525; x=1738918325;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DYxIxldY+18YpSOIneCSFlLcsvrWAvqtkKk/kyK0f8=;
        b=YQ5iwtzXw0GlVLDNXLqcFQzr/p8SwFZxntHWB+mT9RPWT3jN6rP4go0RSbFIcIy3Hk
         WHOiNibTd1FxpFsFzBODVzqlqK1VVJX5hZoirOiwCBW7F2hU/At+zZXJP1y+HWdWaeFs
         8Hf/r40wrAl/n5rdPyWCaGyLhFRkAErEe1egWzwGYlTsz1xAYOHpJLekt1Tt8GuYiDtT
         e0tEo9M3iH++4LuaUc4UtSDtPe+hhLzlelXeK9j9YmzRpTQ5aYHXRGT2eF82HY5S/bqy
         8dGsv+usIImayD7Tv8asmkW53ADqXHrRaTtxHH+ulLLNeCA+D7VQBdL0SnlO9JyoQUrD
         zHDg==
X-Gm-Message-State: AOJu0YyeGNQDl3+rcccqqObhtM3ehS+pEYn+s+BsTtYMYTIGBojc0p62
	ulp/6i6qKPkXCnMprYutrQh+d8ODR0wDOCQKTHW62wC/iCiSORO1QcBCkwSZUJUucCAAbDaZ5cA
	PFuoId2l1NEh+rD0/HBalswo61mYxkw==
X-Gm-Gg: ASbGncuo+ihgUPcVWn2Mbc4Fq7L9XgmK8cEiFA2OhrBM4dIxszty/utbDzR2JVmB+W4
	0byHneN+dMw2vJ0Pl7oxmyE1uf9JkMMvLZ3yiro0kQKc7mmSUKUqwXU/n+mvBmdY9G97+D7cDFK
	MPcLTBF2pyloA=
X-Google-Smtp-Source: AGHT+IE3I8zu6IyZm4hpppjCXpnqRxjc6blBVRnPRL63sRfQxIlAzEYgFnSpPdY0rUKswM8Uos2QRZtrZnV0rPbe1uE=
X-Received: by 2002:a17:90b:5410:b0:2ee:96a5:721e with SMTP id
 98e67ed59e1d1-2f83abdf0e5mr17288046a91.12.1738313525353; Fri, 31 Jan 2025
 00:52:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABC65rMSLALiKz6bjQzacnMZM-oST_isybQ5_6wkGbL+pD=ECw@mail.gmail.com>
 <CABC65rOnkm1djgcuPfw4Oh-3t2B4GxxbC5z=tpmLEpkonogzKQ@mail.gmail.com>
In-Reply-To: <CABC65rOnkm1djgcuPfw4Oh-3t2B4GxxbC5z=tpmLEpkonogzKQ@mail.gmail.com>
From: Atiq Rahman <atiqcx@gmail.com>
Date: Fri, 31 Jan 2025 00:51:54 -0800
X-Gm-Features: AWEUYZm1uTL9P4q7LuJjUfjApyohG8y6krDVVvqgp-GEZN2jdK_-dRoE8buR2ZQ
Message-ID: <CABC65rMz7EztL0QnBJTxG6K_MXeqo8AW98vuuuAXwt7ajLAAjw@mail.gmail.com>
Subject: MediaTek Kernel Module mt7925e causing OOPS
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, this kernel module is still causing OOPS and affecting
suspend/resume of the OS.
Source: https://github.com/torvalds/linux/blob/master/drivers/net/wireless/=
mediatek/mt76/mt7925/main.c#L1492

> On Mon, Jan 27, 2025 at 4:09=E2=80=AFPM Atiq Rahman <atiqcx@gmail.com> wr=
ote:
>>
>> Hi,
>> Pertaining bugs related to the kernel module: mt7925e
>>   https://bugzilla.redhat.com/show_bug.cgi?id=3D2342451
>>
>> Best regards,
>> Atiq

