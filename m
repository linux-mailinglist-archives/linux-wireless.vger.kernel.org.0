Return-Path: <linux-wireless+bounces-23369-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C55AC2832
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 19:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26E99E5499
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 17:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F7297129;
	Fri, 23 May 2025 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUV2vuzv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBAC1FBE83
	for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020067; cv=none; b=O6zZRVnWlrG0P0oIDEsVBRgFXDPVzeX5KYSOutMpKk3RiZWozIlyoVEDTPgvc/NxfRDA81j3JnIRB/9PT1kGo0urst8RWGqnhOhfe83un75zUajqAAzDJsx2G4bIyI1PMWi9rNh1hbpeRaVUBTN4/+HTY8JUUzl1mjiGDQ1bsqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020067; c=relaxed/simple;
	bh=DTB9hglx3pYzoBOSsO6UnBD+6wPv06adtv1APjRM0wI=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=t2BCkyjySQU5aXGIpSZGCwElnMwiu7LbIx+T2X5sSzWFIYwWH5ugaEJ5Eoapkq7PReVFuVgqlhjnPgmy+LW0qHcKuwHQ3c3xuuzqlw5vvuryGKGvefqNWFW3NqwK0KwNm1wOt0RTev98xOaWAARtc0gCXmh25/9HgPaUkCEJl6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUV2vuzv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-476a720e806so653851cf.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 May 2025 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748020064; x=1748624864; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+L9RjaLh+JUJfV2DrKsGxGJ+0F3cQN9zcS4XZ0t5jHc=;
        b=SUV2vuzvJaLXXk9RtysZwwTYVNglamxEREih5ZauBXFBpP2e0dusnMaBak2KcgnvDS
         R1ak4CXCye5Ku+AQOyz19EKnuGUZvulnY4AwoiYb4Hd0dPOiG52xOekuQ+qvTY5pXU1m
         qraI+sutXvWmeoZe8Pf7gBVLW2skLRCHKaeV0GLvCnO/DqPi7H55HPoodE2hyYYqPljy
         WvhA1SpbU7odqL0CQsuLUzV4N4w0eTmFIlv7fNr0yrb/1ExNIRm7aAlJTROAJTQbeRzV
         UbkzHB8z5v8o7l2V/jYwE8D0enPONCdyxKhqs51ADbfkcR58J3Ctc3ol7TV5imBDJbtS
         HO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020064; x=1748624864;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+L9RjaLh+JUJfV2DrKsGxGJ+0F3cQN9zcS4XZ0t5jHc=;
        b=EYzvfwB70GjpoCqfalRZT4gN+jcDbCB156C45R9SsHTNp7P/WRbVg2kCXKiFLhciko
         AzmVkiRkrjRj64P+Loae2lqFE0YxwzFju2PJXmpA/H9F9hsXVljjD/VRpoitazYKvn1n
         qzuFQyCF6qHj6t+4ToNlHhml4EGbtCvlgwAe4LrUwW68syHrc1RXGFsdfDS0Pa886CKN
         aA8wAdWLhbJqG+LtkPm0qKH5iCCD2RAOEnRLKffGuyr0x3esLE5Jd+RcEW+BGdmb/9Sd
         BEBrLVllMclyaANvOsnDvnZcytID8NUUDMCjPaqHF4mdJT5V47mQXBa1pGOpLzafqzWp
         yyjg==
X-Gm-Message-State: AOJu0YyU/oyhG3q8b9fYKS/GEwNBK4b+EgGoKus0f4FTngCc7lcTSHkJ
	X2UqYG/p6JZ+Oi5D0lE4OQZtC6x4ANVdzDoxfhBk9mDYlUO6JaGhsoXJ1BGNDQ==
X-Gm-Gg: ASbGnctOws60GJe2WD0IPUPqaX8hr5weaKzZQhlTtBpRp1b9pHU86BGhM9671smL44Y
	JdYYfk8SdbwxZbkJVBL4uTn1EGYrhyk3EkuvC52bZlO1CWtKoc06I0FEbI14ujX0s+TLB4k54F6
	SQ5wAk47m+1MAz78ZSMTZywX64cadnSWRk+t0+3eAF0F3lH37hhW+VNu9fklPLZnFdwi5fE/azI
	CRzQdhvZXf+J/Bv7koEtnSZcRAeoLigr+SOsrpdLKRNZLz2G+/d409EMX8jZflWY9S+hoLXcyph
	pxlOJJMKchvwOEa2kg37Fn5H4UeTg9CEs8PX3FDtWZ6rxCLknjJH
X-Google-Smtp-Source: AGHT+IGgPOxi9NNuHjMWwQwXI36LImmPtDvHUNlZUV65+yoNyU4FyPAXyAUMx11p3lOaTyZaU11ZLQ==
X-Received: by 2002:a05:622a:1f09:b0:494:a057:81a7 with SMTP id d75a77b69052e-494ae36c59dmr528162431cf.16.1748020064467;
        Fri, 23 May 2025 10:07:44 -0700 (PDT)
Received: from [10.201.20.170] ([71.181.84.66])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-49b8acabd14sm44023811cf.80.2025.05.23.10.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 10:07:43 -0700 (PDT)
Message-ID: <bd2f333e-28e3-46bb-8b2b-b61537ea6288@gmail.com>
Date: Fri, 23 May 2025 10:07:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ath10k@lists.infradead.org
Cc: "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>
From: James Prestwood <prestwoj@gmail.com>
Subject: DMA write/fault when 802.11w is enabled
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

After enabling 802.11w on some internal networks I noticed all of our 
ath10k client devices now show this during and just after every 
connection/roam. It started immediately after flipping to 802.11w on the 
APs, for every client running ath10k.

They are all running the QCA6174 hw3.2 WLAN.RM.4.4.1-00288-

I don't see it causing any delays or issues in the connection or 
afterwards, but it caught me off guard and was slightly concerning. 
Anyone else notice this with 802.11w enabled on the QCA6174?

kernel: DMAR: DRHD: handling fault status reg 2
kernel: DMAR: [DMA Write NO_PASID] Request device [02:00.0] fault addr 
0xffe4c000 [fault reason 0x05] PTE Write access is not set


