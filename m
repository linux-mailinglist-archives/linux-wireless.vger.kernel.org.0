Return-Path: <linux-wireless+bounces-15332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D14E9CF579
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 21:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806E6B2EA31
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 20:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6F51E1311;
	Fri, 15 Nov 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKvCEW3U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686461E1301
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701066; cv=none; b=hj39fhPiEZU31fA1sb9jPYATAq1jTe1Ix9aAxL5fjAYuQtz0DG5HwbBqgzq0FOquBT1BUheSKB3nl2bbuhLhHmkw0Z7dBFHRpTpdGmRkgC+TxOHHZ/P7BhBZeDdprwdV7/oO9GKAXoV9MC8I+QhGo0U0pPRX9dq5A/PmABcsEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701066; c=relaxed/simple;
	bh=0tllZx9Of3KLpu5YjG9NlyM0UxxcMwiUmdsYpdP5M5c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Sg5kaA/eaTMbcneFohEV7rQ9RLee4Kem/FUhyCr81fLr5Ebfp2MPqlIcD1RhOnMdOTPnvWPj3hGrM9YB1O7gmtUYVG0HcKwnhlOBaMP7HXTy8UF40XAcg3/7EhK/PhwO+b9TUl3pUvagHWPdVH/BnaHFb0M9hdFMKrl/pycFNSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GKvCEW3U; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb47387ceso25199485ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 12:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731701064; x=1732305864; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0tllZx9Of3KLpu5YjG9NlyM0UxxcMwiUmdsYpdP5M5c=;
        b=GKvCEW3UNz6y7nNGKLAdUfC/sRp6V2+wxd2Spm/MPABAkju2llbzX/HDQVbliZcTI8
         dunpBKhUZTDviwoesvb73z7EZuB+SLCcDmxBX1esulCu8DxWIFptkkkas6S0NGTkxn2B
         sBFw6KowP4F0p1bBuIo9boiwN8BPQqSjA/NStfWNr4VQnZ/h6cpgQFnmVVuDw8zMDAHm
         yoOAEeI0M+gVL6QOO/GaZxcL0Ci+RGDTO/tPppcqLvJLnPQVS4tUz0PD8Qwkm0PhZnFj
         pDvKSjDym5wik4fqkPm3fBrgOUcIK9It9imFCz+LOtdYIbhqofXDV4UZjfqf2VJDOtid
         B/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701064; x=1732305864;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0tllZx9Of3KLpu5YjG9NlyM0UxxcMwiUmdsYpdP5M5c=;
        b=UOTHQbLCmsIzzSRvM6P4kat8FgQVWy9+8BEJ1QVepDSkcm8Bzyy2ccsjEtobZ02Ak6
         vhdL8aZB5uKbGLOX3FZI46GL+vZmUmfVV3fNmYBGq/Ly8cVl6Nr+ZFPr9C78QLTH5j0t
         VBWMdZGoAbEdJx/V78kxan0+02IDlUnoSqmE3N9pFfCVXXilQTDA+tmOWZjxK6GquuVe
         rzx/vlMx3tDDD0N7Imvk0F5+iEIgauY9oQh9LJ+8qgyNzbs5AchpJT2GBdBLBiYL+HMV
         rIClkK2/5PaFIH7K4XEnFppPCoxmv29RAMtY/CZkiZEg+p7KBg4LoPTWtutYGGZtTK2v
         UaJw==
X-Gm-Message-State: AOJu0Yy3LBaJ932b1c1PMabumu9Xx2jt6HrUv108H021kJY9CIaHG02r
	xgsBbbWCDseOPomy2Bq0J/5oxBlaB6/r/MKT7ywUjeCKdylT2xRz94/ptSqGzUsGDOxfdkg4L/w
	/kMsJo7ZHuXORzxi1XU8fVb3kLUOWdrxxlCjJVr7U
X-Google-Smtp-Source: AGHT+IFauZMicTOO3TkdEKamOpGX2av/xIsv4r9p0AXBq6ixrhCnUDURTGCzCtODU/piRSQ6f9VSdghZnQKR7djoz8c=
X-Received: by 2002:a17:902:e742:b0:20b:5b16:b16b with SMTP id
 d9443c01a7336-211d0ebed22mr50930805ad.36.1731701064096; Fri, 15 Nov 2024
 12:04:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Bulatovic <combuster@gmail.com>
Date: Fri, 15 Nov 2024 21:04:13 +0100
Message-ID: <CAPGdDAmPp80VEZ0TG=cS3QAYKqELHfqChid0wYZ7eLAENFY86Q@mail.gmail.com>
Subject: wireless-regdb: Updated regulatory rules for Serbia (RS) fails to load
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

since commit b44edb2eaf3a917fbd7005f05c6faa202c984152 regulatory.db
fails to load when country is set to RS with message:

kernel: cfg80211: Invalid regulatory domain detected: RS.

Offending lines are:

1646: (5725 - 5850 @ 80), (24), DFS, AUTO-BW
1647: (5850 - 5875 @ 80), (24), AUTO-BW

OpenWRT is impacted, but I can reproduce this on Linux also.

Best regards,

Ivan

