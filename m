Return-Path: <linux-wireless+bounces-13949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 288D499D9F4
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 01:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A8BB21B3E
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 23:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F3F158D79;
	Mon, 14 Oct 2024 23:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b4N/dLyk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135901448DF;
	Mon, 14 Oct 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728946925; cv=none; b=tcctjGw/Ze9Va8n6yzNt0/tngxC6yhUIkgEwtSsldcU0SNpKCqZOZt7msCPsh03x1w00Z/vGxBMo9yGiY6oGpwS1/40McIRj0k0v+UeElX9CPr7CNVcGVAFpcpZ84TizhH9v8EyJ7evFBQU5FrWlM7Nrjm8T3/TaQ9Yw/W9PPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728946925; c=relaxed/simple;
	bh=isxeY2F05qQsZ2WKXbGh/MaxpRRZpflVYsLI4JN7mzA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=s9m9ve3iDSlVs2t/uRHC1cut5yvXMZO9qq4u7Rw8Kgrp7tA2tw9d5mkrcA6JpzUnnN+Kkn7df2uhIYPDpaXxKSIZqMaVNa08mx6cVCvxUg2KWbnzfjma9rafgiZaCsQ+NOkFXZlywAd/SV0c3daguWMaJqhjwYPM9CFBbFpxt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b4N/dLyk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d49a7207cso3042232f8f.0;
        Mon, 14 Oct 2024 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728946922; x=1729551722; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIkS7pzP1CV8VNgOcTKZ+pJdHHTX/0kd0qi96EfGmwA=;
        b=b4N/dLyk4Pu54nZpS8+5FCEeXtWYA5XmucQvLXafmYnihamCgzXOI1FWfLMyq9K6au
         VgIwAXNw3NCXJVwi3GlJ4izxGLYqX10Dj9WJxk7heZspNpGJgT8+oEf2/KAYPdXpqueg
         AUvVZa5Hn0IKKwILsGPikB6vO4EtdlMHaLQ12PuOG9junGLE8oG/OZv0wCL7aGjRQHQs
         MKUUI4vs2MlvrSAHqvxIVsot7UL6wsor9O1vjCxhQ4LmxV3izUxVAu0bQG+Cytp1A8kB
         DqjSRXfBMX1hli3bJnHNxIqEL1PWfcYTQuU/F+CQUjEGgxFEpVbJ9ICxHvr2WXnlZ6xZ
         wmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728946922; x=1729551722;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fIkS7pzP1CV8VNgOcTKZ+pJdHHTX/0kd0qi96EfGmwA=;
        b=LuvAYlX1LHGWwWkKdP+DBsBSA7kDu+f3wCdmxTMwrYNS+lVY9MPDXdKWTYa4uOb/Rg
         CaDSbFjgErCKlko803T2FdLJViL2o01HlojPLBDZHQ3qy/fBuUXo+WommaNJ+lQcq6AD
         4j2DZ+HoJVfI1pSXDhNAXOpleqCfAhQjdxs/aoOohKXjd1YBugu1DEYZ24GNBmwkqose
         fJtrq1wDhIywmODwCfLejuzjgOOZz28WqKXXMVUxs3m5I379J9VHNUelsyiFJlJ7nKWP
         G6I7pIqqn9SNCY35ZsQeFCQ0y5Ej7iKMiT+JdWo4N1EI89br1vp06/Ae4nl2UcLzDZ/1
         CChw==
X-Forwarded-Encrypted: i=1; AJvYcCXDLsv99vFSquiM400rRIRXRlZ7CXgXMQOZ7p8KJBTCCGKFIFtnSrdLC80ztqZdBwWivkNKeN359305ZOPazA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3ZcqDMwwWPWS7yloVtlhiP1MWsQ7OyWIdSaPVrPfpb1lHhnn
	/yAS64VkaO1y4gtYE7LtBdHFjkiFjoxpoisxFLOyYMSFV4Y3WevCEh5qTg==
X-Google-Smtp-Source: AGHT+IGtA4bl0vTDiM0+34/hmRCDBCj/NNYNNYyHfcFZcCHzGIIQMEEMETQwN5PfPgRBOylVg4J0pA==
X-Received: by 2002:a5d:4d8c:0:b0:374:bd48:fae9 with SMTP id ffacd0b85a97d-37d5ff2a6fbmr7178985f8f.20.1728946922222;
        Mon, 14 Oct 2024 16:02:02 -0700 (PDT)
Received: from [192.168.1.240] ([194.120.133.80])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c7dsm105712f8f.42.2024.10.14.16.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 16:02:00 -0700 (PDT)
Message-ID: <9c02683d-c688-4e39-913e-6b20b3bd76a0@gmail.com>
Date: Tue, 15 Oct 2024 00:02:00 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: incorrect shift and mask operation in
 drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Static analysis on 
drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_n.c has found 
an issue with a mask and shift operation in function 
wlc_phy_rxcal_radio_setup_nphy() as follows:

lines 26326-26330:

         offtune_val =
                 (pi->tx_rx_cal_radio_saveregs
                  [2] & 0xF0) >> 8;
         offtune_val =
                 (offtune_val <= 0x7) ? 0xF : 0;

and similar in lines 26376-26381 too.

The issue is that the expression pi->tx_rx_cal_radio_saveregs[2] & 0xF0
when shifted 8 places right is always zero, so this looks like a mistake 
since some value value between 0..0xf is expected in the second statement.

Since pi->tx_rx_cal_radio_saveregs[2] is a u16 value the expression 
could plausible be:

	(pi->tx_rx_cal_radio_saveregs[2] & 0xf0) >> 4
or
	(pi->tx_rx_cal_radio_saveregs[2] & 0xf00) >> 8

I don't have knowledge of the hardware so I'm not sure what a suitable 
fix is.

Regards,

Colin


