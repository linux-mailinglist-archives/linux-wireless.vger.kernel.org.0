Return-Path: <linux-wireless+bounces-9330-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63AE91109B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76E21C241E8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697E91BA069;
	Thu, 20 Jun 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Om6vu6Nw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B69172BAB
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907033; cv=none; b=ZeUoKJOgKSH3LW7Yu2gNWt8hcx1w3PaouXAUtBySgPCtA37wgN1L53OFed/gwqChht7qkYW4C+pwRzbAzxSD+kTJc1B/k+fbGIr5IviiPWJSi4PJRmk0rc8D7Rok2RB+1x/RIwgrPQChgjD+YIZzkyPUnBoCQyLBEJSgyeutobQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907033; c=relaxed/simple;
	bh=7KSLLo5xgQ3E4gC+/JgpXOvCMV9HdgQ6gocSO/yqzlc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=F+NaDKbcyYtljPn1ne5D+PxtA0kjHBLakqawZhaEmnuIKcMcC3LK55yWjuZSDfdgfFD0u0hZptgpLv8gO1RAzXkiyHgFnRAycdJekDBOn8YIYkca9brpPGwz0QZy4nuvxjRI2ua/W7ctSJI/mig9NU8JRTnD4R/tLRvW7gU+e1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Om6vu6Nw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57d280e2d5dso575902a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 11:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718907030; x=1719511830; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FO/e+Ns55xXM24FNzXSnFTgZvSM9P4lXDa+2qY1REi8=;
        b=Om6vu6NwDzDAaTfSei8Zi9sXXLgR4Ht1UIxVeoRTa35kOMIWawW692ynNe1w1nFwGf
         EQuNMCP7IHgBkapkOBVspsEA9ixLexfEP7ewY7oJd1lEMSN2J30p017hHzVZa2CLz5mL
         /KJRgWsjbfccwBEdDCoF81XfirosZD8zqL6JNcTOg/KJFAqduWWx/E0oI1ahoGApddXH
         I8DUcADZpL3vTFkE0V5aL2Cd5qiXNQkHHmNE8fOuOle3sHsVN7ucp+MmtycNpkup4wWd
         YmnxOheF/t9TpVDl1icEUCGFKqHrcmb7C/pbhskVEzSoeeljzyJuAkW1ZrFi1jlG8CSP
         AhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907030; x=1719511830;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FO/e+Ns55xXM24FNzXSnFTgZvSM9P4lXDa+2qY1REi8=;
        b=wdsO+aDuLHdTlWBl1uXsGMiQGTTnw3YpG76/VMJlN5mSlS9u6KPzxMA2BPew6LszIe
         n23IFsdLiwvVvAIEDYyBu28sx+oraoo7UUr8qtCGXc07kptm2xnYjC9bKwn7uYjdbgTx
         Mnx5K4MpqOzktPxQNKeWS2bpCOzTh4ar2nsIKVrqlxIw7HSxBLRt7DgP+PiuwAcsQ6UW
         w3GKiJ6tc0kBDwLiEsL1TaLAewCvp6YTjaTsWrgSlLIXrQwGo4IFu7xCtCKbgUVH4HMr
         zRbLrHuM6iv6eld3Qud88uvmwun6wKO9cX53ayq3cq9Ipb0UjmzkF+9VXISmBE4gp+Yz
         T8cA==
X-Gm-Message-State: AOJu0Yy2T2Lhw+RSFXwY+OWZqRFVz7SWakRs1KT/C0v92OlQNT6h75J3
	UXkjN8VLrRJ/UnWcwpkWMSMwPkTI+B0+GbsYiqe8JKd3Po3CfmEieTlfGn+FsoZz2kzUq9XsCfG
	Omp7zVOPcOHzh3ZXEiGJetR3Qqprfe//f
X-Google-Smtp-Source: AGHT+IEV+Ds1WjVGZDPYx63+yjTCbd0Rga5DmkBpZUfakJNyUGiesWDevoOykdkOcqJ+VKUs25461ok/5M4FfuBlF3M=
X-Received: by 2002:a50:8746:0:b0:57c:a4d5:4d04 with SMTP id
 4fb4d7f45d1cf-57d07e7ae4amr3736232a12.17.1718907029887; Thu, 20 Jun 2024
 11:10:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Janusz Dziedzic <janusz.dziedzic@gmail.com>
Date: Thu, 20 Jun 2024 20:10:18 +0200
Message-ID: <CAFED-jnTOkH6BwUAUnTvr9SSqrwV-2fUCuwywwt+JOKQJx__ew@mail.gmail.com>
Subject: Intel BE200 - mld/mlo supplicant testing
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Ben Greear <greearb@candelatech.com>, Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"

Hello,

Just check:
 -  6.10.0-rc4-next-20240619
 - latest supplicant

Seems supplicant report:


WIPHY_FLAG_SUPPORTS_MLO

-- 
Janusz Dziedzic

