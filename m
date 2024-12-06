Return-Path: <linux-wireless+bounces-15956-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 572809E677A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 07:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352DD165F02
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073C8194C90;
	Fri,  6 Dec 2024 06:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b="WeOLn0Nc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4AA28684
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 06:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468010; cv=none; b=esgIRUyHU9ynNrsBI1KYNf7f5mF6q2pop0DLsx2HD3Szx+JDBiWDolr6nfA1I+0NoBIV9Zf22bQk3A2OejDbyFdgrHttIRd+QxVsQ1Z22UsfTQ4sv8Iyy+wqRCugJtJJXMKnQ1kbJX8mSo5pg4WjctXr4lQprvjY7pWO6gFXdZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468010; c=relaxed/simple;
	bh=wrZr1beRX9HuHcxoeJk1rQ0hJuM7H5QOfPFXk88NJko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ3rcS3NemOBjDpjahBS6UHeVRReg0ATq53TZF9Z/GIkrQUNxQ8tM4M9ocYqaHt0AMFdufS1q12VzDT7uDUq6iDCqLaaPeaqV9HF4yHjKU3i/bBfSXL8hT8RJfCfdvPARGZa7WrVenAHKO/DNDbW75RI62T+2ZcUmgPoTUkBP5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com; spf=pass smtp.mailfrom=formulatrix.com; dkim=pass (1024-bit key) header.d=formulatrix.com header.i=@formulatrix.com header.b=WeOLn0Nc; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=formulatrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=formulatrix.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso1267235a91.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Dec 2024 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=formulatrix.com; s=google; t=1733468007; x=1734072807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrZr1beRX9HuHcxoeJk1rQ0hJuM7H5QOfPFXk88NJko=;
        b=WeOLn0Nc+FtCP67PxT4+jFs6rEpiMS6gCHp9al0xgF8S4654NvMF81hK6IfyQiihNF
         lIuk8FF86zUCZODJhxZCoIhwpJye3Bc3QrGRi6xldbvpjJSzKb1Xx4vzqhVpIApUzPGS
         t5jCJjTg6CnA1VRQPH3liyFfAkHi3pnNHh3Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733468007; x=1734072807;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrZr1beRX9HuHcxoeJk1rQ0hJuM7H5QOfPFXk88NJko=;
        b=TOgzB3VD+F6nVbzr4nGrh578PO203jD9NE/zzdU2VUeqY3vbFwklv7TuO/AUK/PJU3
         PFQXSOZj0R3BLAxQ/Y+Aw/vYe8oPRCSJ0XH6QkMUWeYreq3VMAPVrJGW8iPbEAAayqmO
         EahiwjS10FF7+NGOTR/QmwvyESW1lEOEYwEeHh78dbDU2j1zRGusZ9asszdDBokHNNy6
         I2M2iOtWRTuckF0oyhZr/ydTQYsK6kGePQKvjQ6w3ixOliK5Uu4Yrvz/qPC440xClpgy
         L0PjD+w1vzKmtcezMVc3Ult82MsVVs1LqX9LC/PPUSK23iQs0HZVafQwZZ4A/RAd4aop
         6R5g==
X-Gm-Message-State: AOJu0YzdLFSOMsht+9Q/C+GVO+RFvKsdqAcSzfpQaLzklEeFy7cV8PDl
	qVS6mVWfAJvIxZEhB0XKgJCLlj2sb/H1z9+YVD+QfFonBWiu2x1zw+H0mWe04g==
X-Gm-Gg: ASbGnctWq2GWUNryl5Vm/0bRqw/T7MyuGbm8uHiy/84H+UGvoa9Uy6Av+2TVxhfA2h6
	TN0JEmnHuQ/aboSfCSteoJkpd4CGQcoLQgF8rX6lDorTKIasz9aG/Yi87yNJRYzWAXrkpzjL9FL
	Z9CqceOBqXNSEcP8HEc/FV6ouiE0UnBtzV+fsuInqCIyTm5RbtMrZrU/RLJgVnBBIKKP2CXFq8d
	AC6HQrVlUSSna4Q2Fl/Zxr7aD4mk5t/Q18zN+ZmW+Zyo7fwDxaOM6L40+QWUMtkxMOAvpvbQxso
	J6HNVhQ=
X-Google-Smtp-Source: AGHT+IHWs6sGdgiWiNc12MXFefS0Ng8Iulw+kdg9a+dLKMonsRmqQ/wFSNsyrDBpUXaO1jzRC0gvwA==
X-Received: by 2002:a17:90b:3a50:b0:2ee:9cd2:a589 with SMTP id 98e67ed59e1d1-2ef6a6be86dmr3285365a91.20.1733468007704;
        Thu, 05 Dec 2024 22:53:27 -0800 (PST)
Received: from SE-151.formulatrix.internal ([103.12.224.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef67d6ea84sm969667a91.47.2024.12.05.22.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 22:53:27 -0800 (PST)
From: Renjaya Raga Zenta <renjaya.zenta@formulatrix.com>
To: arend.vanspriel@broadcom.com
Cc: linux-wireless@vger.kernel.org,
	ys3al35l@gmail.com
Subject: Re: brcmfmac: Unexpected brcmf_set_channel: set chanspec 0xd022 fail, reason -52 - Part 2
Date: Fri,  6 Dec 2024 13:53:24 +0700
Message-ID: <20241206065324.91702-1-renjaya.zenta@formulatrix.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
References: <6b2fcdb4-f00d-4a17-909d-f92ed0240cbf@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 5 Dec 2024 14:10:51 +0100 Arend Van Spriel wrote:
> Can you try the patch attached?

I've just tried this in 6.6, obviously the errors disappear. Tested with
DUMP_OBSS enabled.

Will this also land to stable?

Regards,
Renjaya

