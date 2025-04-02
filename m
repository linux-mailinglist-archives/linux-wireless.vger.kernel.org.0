Return-Path: <linux-wireless+bounces-21045-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E32BEA7865E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 04:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED887A4023
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 02:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400D26AFB;
	Wed,  2 Apr 2025 02:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIjrjUJV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53612E5D;
	Wed,  2 Apr 2025 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743560543; cv=none; b=EV4+B0yHanpmbZ/IlY3BLh+y9gNejxuW9i9gUjCg5MxMBbd+w+zlF8LtLfVFrAqocJsfkvDdVTfefL8iBvSzOos7Ybq4RecW247WiGqKAbZRaWCEcdwH81nUo1yECMfPi++vHB4XoBbueQcrsQvxjOxN3TzzkDpm028e6UT88M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743560543; c=relaxed/simple;
	bh=Ezb0gXYiADCJFtFN0p1p0sirzr0898/9abeWN2mwekw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyEOR8d1UrzK5I/SGk82RgRzt/h8iHzpmMdrv/wR9mKKbJaOl0iWT0mYyYJU7HjYyDMYvFFY6NzJd3MOT8D9MGm1azunBczZdKkqQ5ExHYiT4Q7sdhlQvnQT6To4bCXzhTJCkrDCtvmf+LUnMmS5x0A3XcwIfOM2MiVhuPK3KlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIjrjUJV; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2295d78b433so29188375ad.2;
        Tue, 01 Apr 2025 19:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743560541; x=1744165341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8MPdUgh8f/qNoFhRiTrVF2+aMX5OLujKTxRfKz1h/h8=;
        b=MIjrjUJVjGG/YkQ54/EEp/N9FGRR2QWnfLX+RGXpZ8Kv+ZJWrvVqKxJoFkfyNJcmzl
         ygGylJknC8Rq3B/MQaACByxXWZEriJcOFElcqFoAUiZ2BZolujRJAuScmIsZNgpbNxUk
         rAjl/54uhxsStx0L9d/96rS2gWEM0s5F4NeaH6ybuC5lI2mWxdIAWKJg2NQZfeCxQO4o
         zLh6W16y7LHUdTq3iyE5QU/gYzxtWRQW5F+ieYS4EYYicg/508yK5pfsasFGRK6PcOcG
         3oYy0AxF7HlAr1UN16yIl09gixyyzE1aV20TAbAUtRtmyVAEEeVc3Fv8CGUFXHUmvB1v
         uE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743560541; x=1744165341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8MPdUgh8f/qNoFhRiTrVF2+aMX5OLujKTxRfKz1h/h8=;
        b=A+NIiku/3wyZzE/LkqgqPfHhCgG2QRwE/5XgLQ0mBtNpH7aUCa5QUQZKQyL1LaxqAk
         e3ZdJ1LI448AL4JGtpUzQpwZbCRO30brEHin+1YcLckTLoNsHz6DW3KRFOzSHhqA+0nD
         xoXZesojtOm9JToDQvOvvmQc+HN2ORdtwb27WgQbfHGdzU+9XCCow0/mqme/PeSVz2DP
         O9WtPYr1IvjB6hz5cWhvORbVR36OtA5FzCzpgWPbFiVgf0igscIHL8wIYWyUk8HFdc+U
         sdd13EKtUf0KOYybdWNt9qOn1muet1ojDVGYyV8EBZuVAOoTtCyzi2hPNvQLETRlgtFF
         DJHg==
X-Forwarded-Encrypted: i=1; AJvYcCXfeWYuFTDL2FCs96w5z9N7hsK9vYUPkkOgaPcM4YTf1W1S5v8rWgc89L/iKC2XIKe7eosK5+emQDanQEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHd701cU9MRLfO4iic23WLiFD2WEIsYJASx0WsqtZF0OPlPjjo
	EaI+PyJUv5JzqDuR4gMXWBffElz1n7QfRM/09lhbWKtooCfJVfHs
X-Gm-Gg: ASbGncuEsyxT2ltZSn1CQNwHJS8ESBGElVzKrBjZOEuf5duRUMBhIjlphC59oFvvVWz
	mg/EE5Nlx+grLrugWZwv1nVfuW4SgGcL9e/9QIej2hUuQlxedi4e5DQYGfOyCOh9mIVqbFMp1od
	X5gnPP6jIx/e0VJxcjSC0YyeJtRdm3TD5g2Ngh1t9ZMlcvWShsHo+WBmwdJlDX/y5AqM8fsiFzF
	oOKl3WRK19h6NcxxFVgUfHjV4idKDUQDCk6et/diN9lq4MNt1OJEwm1V/OtQrhFqtG0zkTm4LX1
	iR8V0e3MVSAf7Ie4Q5g7T1rMCy8PZJP92r+3g4vB4CUK6eGdtGNA/Oo+U32Oc1HlMkpeTos=
X-Google-Smtp-Source: AGHT+IGthaBJm3CXEP2yCOB9RHfLuP8APhDG0hC12B14aou92sDbgmPo84Jth75Yx54QYIPHG7/gTg==
X-Received: by 2002:a17:903:2311:b0:227:eb61:34b8 with SMTP id d9443c01a7336-2292f9777d6mr214498325ad.25.1743560541421;
        Tue, 01 Apr 2025 19:22:21 -0700 (PDT)
Received: from henry.localdomain ([111.202.148.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eeca2cbsm97204115ad.52.2025.04.01.19.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 19:22:20 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: bcm: rpi: Fix NULL check after devm_kasprintf()
Date: Wed,  2 Apr 2025 10:22:15 +0800
Message-Id: <20250402022215.42834-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <195f2498f70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
References: <195f2498f70.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Arend,  

Thank you for your thorough review and catching the return type mismatch. Upon
further investigation, I’ve confirmed that this issue was flagged by static
analysis but appears to be a false positive, as all call sites already handle
NULL checks appropriately.  

I appreciate your time and insight—please let me know if you’d like me to drop
this patch or revise it differently.  

Best regards,  
Henry Martin  

