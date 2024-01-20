Return-Path: <linux-wireless+bounces-2289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D41383351F
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD1E4B219BF
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4113D76;
	Sat, 20 Jan 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5ZDxaUk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C9815
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705762565; cv=none; b=dKJOnYaRY6vb0FivKnftkz5skYmSagJ3Tn41kJuusCUmkm/iEhD5bSpHKwkXPiEdHb8WNaZNxsIjs3jfclcMJpReCBN1BT9F/g7lq7O28K+5ETAkY1MTY+bqLpMctJ+WbV7m5L02aafKnMnfFZAuuzmHpEVpAlOa2O/USXSEnjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705762565; c=relaxed/simple;
	bh=myPyhS20wHykePfbq4byRX4pB57loG+G4GrtyP9qRY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nuvIqvpLKaDHrNoGi7UbQKeGGUYBDNKorlixus1Jyl34c+ZtfUvhSH+bhnD92B7QO2hwWOjynpyjncCdbt/vbuzVLuxhmaXnnbFRnVAyWlZNVqgYA7Zp6BNlOhkrIcA+AngrpXbpH4nM0DPPvO6ZyWgRNpWX0dQY/5GDAF8Vn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5ZDxaUk; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so2281295a12.2
        for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 06:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705762563; x=1706367363; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=myPyhS20wHykePfbq4byRX4pB57loG+G4GrtyP9qRY4=;
        b=J5ZDxaUkzJ7WPBQ3Gr0DJwa9bbAfpAG8Sd1pQG83WvxCpVmF9uZ6bIfOHLj4FBGEE3
         S7+ufrsAbgT9VKjyvSiEc51aNUyMZ6AOQ1u4s4s1XKZ1qrSLSQaQVLSL7daBxGuXtgf6
         iN0sUIEZY70Koy44HLNXmCazuofqRJGwhEY78zB2hnRNXS11b6AqEgvqM/HNgqKJbqh8
         5DCbomrW35hOHI7W0ovGLOpc7zgJJd81yHXOyp+vGuD27OV44jtPnhd2+leue/y8MGXx
         Pu9rNL0uwJx9UOm5+JTttAr/l7Z9Vi7Y2eyhPauDGmZL66HMkqoDRGPZ1UBhBU30neqV
         tv2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705762563; x=1706367363;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=myPyhS20wHykePfbq4byRX4pB57loG+G4GrtyP9qRY4=;
        b=siVosB6QENCUGbmg5bEiu8R6QwWydC9h8qp7/rbNmsSanVYFtoMXXqF57RjH9iQX6l
         tX6yAKYGfXjHPy6N7vfoE3xrzx1VzOuT7ouRdaRKqFXBZ7/UkJ/pk4v3rOWCt9kFGKK9
         VIu10hzLAOsAtm8Bq5hKJrkSjc5we7PdUpUGlQSOy0QeSjceYC5CmlmtcF1WgpSyMkrv
         tpsjsf3YKu+JJ9FEhK3M00Holn8xfKLlgvwP0/li81IyM8Ke67ryDSQpgJOhaH0bylvE
         Jf3S6RNRsyPgYm1xIHReOoN90PwxUC+bhVRaQIwKNg1jR9m70SdPK89PX/IsRs64/K0F
         CRSg==
X-Gm-Message-State: AOJu0YzEy/U2xgdCP0olylDDrXZVMg8EzAJQQ0Ku+1cmdIWMCcq+jK7Q
	hFELyrQfv953N2jeRZDwHAjEXmIh4sycp4J0uBl1nsK7MJMPyBbu8xRLYFV5voMCX3pbQKSXOE2
	hMh/sDYO3hPnfx4Sckd9aaHrh4n8Oy3bnXAE=
X-Google-Smtp-Source: AGHT+IFMeQQkCng8qpkFs7hz1bCUKrcXceV2rxl2Irdhc8xICD/cloIDMmtcHc4Uh8vHS+7vOYHK5I3upd9nJ7pJFIM=
X-Received: by 2002:a17:906:9ca:b0:a2f:c879:c388 with SMTP id
 r10-20020a17090609ca00b00a2fc879c388mr334310eje.168.1705762562584; Sat, 20
 Jan 2024 06:56:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118111941.549593-4-johannes@sipsolutions.net>
In-Reply-To: <20240118111941.549593-4-johannes@sipsolutions.net>
From: coldolt <andypalmadi@gmail.com>
Date: Sat, 20 Jan 2024 16:56:03 +0200
Message-ID: <CAJvGw+BM=kRwSRPM9QjgUXNFFSnzq49FztOgO6MoOc29wdkTZA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] wifi: detect stuck ECSA
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The AP is an Asus RT-AC53, firmware 3.0.0.4.380_10760-g21a5898

I tried those patches on 6.7.0, with them it works and connects fine to the AP.

