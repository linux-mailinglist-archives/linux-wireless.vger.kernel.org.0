Return-Path: <linux-wireless+bounces-22667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF4EAAC794
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 16:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27392177A06
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 14:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA77281503;
	Tue,  6 May 2025 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApkZ68MJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29D3280A56
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540838; cv=none; b=NJ/6iuOBStgx43rUrAdMOzsnOygRbnEdOoLkc3vQezYVH8b1dQX+bLvurVbftTSXEMqoDQb9wUa1kYThQt6rkKeM69mX4nMn+Go6CrxPraVJ3Nlm2zjXqqlm21EXbQmzo+7GMx3QmOgOZQJg1ifz42rz2nb806+6suVBVtWOX3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540838; c=relaxed/simple;
	bh=6sjpscYMfhd4p8HS7u6QeSb6lBCzm9Kx6807olSYgHo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=HrNt0pBpxMIf1XRLh+j6zJNqKjdP+47wQuiemeAmOihKbTI6eGW2/QlvB8RYeNRf8EnYKU8d/uGn+BYPV+ORvexkpJTda28/VMXDvsTZBLDWnM8cPx4HgamD3i7s5Jv9LwxfChVGK1q7C+2ugH46h1IXSROP1awnJ0ttftSif88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApkZ68MJ; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f0c30a1cb6so41672836d6.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 May 2025 07:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746540835; x=1747145635; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6sjpscYMfhd4p8HS7u6QeSb6lBCzm9Kx6807olSYgHo=;
        b=ApkZ68MJY8Ue0ACPVquyZyhBcASrB1N1htrdugPAIO8f0eraVfJdy3WS+4O3L7/ayC
         PtH0btBmbTGFm5//1jOFia09bBYFtPk2N5DHCl89AUdyMwcl1ReD7AhIwyYZ6QliOWdE
         VGuD5bOTUmi6hEsQwP23qdTzYRcRD9/zfUantCkwnO3GDe6AAGFbDFwBvOUFn1tcNtVK
         QZ6HEh0ywDnnU2JFb4vbtbACpli0CNgdnd7yjMMYA//hkq2Ge1ZXn3j1dZoQQBz62vPv
         4FvXrEZrlXH4OPEnjDIcm+boJtV8qIHTQyH/YPfBMvZtAf6lilxHU6GlR90oTyp5E4w7
         QFqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746540835; x=1747145635;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6sjpscYMfhd4p8HS7u6QeSb6lBCzm9Kx6807olSYgHo=;
        b=KwgFEoFqpiSZtVkiCx3x++Vhg4iG+p1HsBgEMQFm1JK8DdBhzdPcIhTH7Cz2s+ng5P
         Db5KJ5ssO3+CVNAzw6mVRDEUIrhM15q4z/MXgubh5CUb2FYl8/Af9aVuixFnYuFvI1Kt
         m4J1SMpTsC2kF5XtmFJn39ay9ux0fekeuSTudCv039thPcqU/ipNjwgchjuDO0vw49vn
         4bKj+bMFcZQuW9a4YZYFo0sHFB6dqudkGuWFs5XadZE2oEuE0rfnxHEbFAvftbKYOUHV
         yeLXErrb781SyPxlTEn068ijUTx6Ej3aZT8Tb8ELhJE2CEOs2CP2oFJQ/T4AlL4YlNMV
         ZtlA==
X-Gm-Message-State: AOJu0YwwQXGq8klNAylXtvBRswek4JoxTmvliw06wBLabykMkMV5yrWP
	FpUcPdNRHWrL2OzOyRwBHcOWzJuW+VGCkDmGEhgSK/AzQ+UxWXHfIr9ITtzelYmC15eBOJcqkUG
	x/jP54SdoVGUEcsdLYtLgFhJ56LrSB6LI
X-Gm-Gg: ASbGncte5pJ5r8/vUvX6OuPspC700NeikPBPAiFDib0OjLW37ASJ0lWFKkT2UO7cLhq
	XwIzmhaw7lT/MyuyxmNvMQh71lYFK4c+vNYJOACuY3FTNAn08T1NYu85bBwRTKd3JpXanA2LZI4
	VugN2Qmt4lmJnzFpDcLYBumG5wYWngBWU=
X-Google-Smtp-Source: AGHT+IFbiS9u5KCxi8tya/oKflLFmB53VX8hdl0G6iagpioQZ/oIwasTQnNbQyELaaMALU4t7HoSs5QFbhC+O8/Vh9A=
X-Received: by 2002:a05:6214:f29:b0:6e8:fcc6:35b6 with SMTP id
 6a1803df08f44-6f528c3b47amr178365606d6.2.1746540835448; Tue, 06 May 2025
 07:13:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Oleh Franchuk [zero-gear]" <0x00.gear@gmail.com>
Date: Tue, 6 May 2025 17:13:44 +0300
X-Gm-Features: ATxdqUFEEVzoiGrvvMKKZk79kbFzENcU8mkeg0jbYwKq3gbU0r68JCWUjhHhIlk
Message-ID: <CALw25PY9ON_EVDmr+8=2+EpW3-81JN+Hpq00F64AHmuPBT4mCA@mail.gmail.com>
Subject: 
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

subscribe linux-wireless

