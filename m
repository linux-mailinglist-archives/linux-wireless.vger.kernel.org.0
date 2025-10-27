Return-Path: <linux-wireless+bounces-28321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E9C0FCAC
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 18:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FC414FCFD4
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Oct 2025 17:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364EE31A549;
	Mon, 27 Oct 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chXtgWv6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7D315D2A
	for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761587445; cv=none; b=kB0nAN0FYLmEutINzCV8msIAQxhC6qlZqUkq6VO5P0Uc5DOMKnesANaax9Yvm8//DrKMPoAxwXXT5YrOkYidV58TxqEnJ6MphYkJQojqs9I/IlwqvD256V6o4l4lJqh/H/gNATmmCUCmBYizzPH3a3pLUEjXUeBRNHAc5TF5S0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761587445; c=relaxed/simple;
	bh=bdKOi4YQCsGQsKdKtMIrpIeObDpZmEpfrbyf0ia0seQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBiCMpXU5P8Fis1uuebD2y++bSlAoatvy4sG0tLs+IRbTFAQ08jDZatNkLZ6PgpuJQVJgPaGBFsq5BYI0x+YVsTi/3XkgmQ+i8YZozEZzXRKqq+ylvFnx4g5yYjBD7n23Q7IrRJ+m3kdcEKwOL3CA71H3w8qNYyRwg8KflEpU74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chXtgWv6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47117f92e32so44401185e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 27 Oct 2025 10:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761587441; x=1762192241; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bdKOi4YQCsGQsKdKtMIrpIeObDpZmEpfrbyf0ia0seQ=;
        b=chXtgWv6B2hUNDaNo3rhzlcsL9GqkoMzFCB8Xpl+DBQJuWvoWYmDln2lgCmQRTxTVa
         OiHIpqdAj5IbRZLr616mUybNehgNZxWdfy4uBId9jmPPGmQGRuid991Mx4adW3319HBR
         lnqKynCQd99BUjsAQdWHWgc/fYQI5wA87LnYfbyN0jbHnpNKHEiiwaI9bCh0dTO0tpj/
         TUlcgPWTNgv4YlYxRt1Sk5Lf3nGUgcJQUc6ofqVTZf+rSuj9eXpVUSHEZc3ca8kLhJJk
         mdnChGAOx9ZYOoUT2uVzOvaymjxHTILhDpzm3GztadKXamhFYUXCYJ4yKeZYaKZztp7d
         +5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761587441; x=1762192241;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bdKOi4YQCsGQsKdKtMIrpIeObDpZmEpfrbyf0ia0seQ=;
        b=KdrNYfyhKSIhX2kN1rBaCp8lFRpSdnVm/+o4HYHKmf+gjgO9Fuejm0dq/YffFmR38T
         LsGOiYykoB15Isj9+ry4hw5lSgd62Bxse8qbM1tlvY4OgKQO+ymfcOXHIheZ9DwBvSPf
         T0u5ntWmBohNC1Cmwzx7OAKige9Kw+6ER+KXucEq6b4ie84ulRG5HzIefA3KzFtAZRZY
         68sCWZsCwa1pp7A3hA/ScgthUtk7OxQzoQgBASThPC5YMm74+XToL6LCcXC2vVln5fn7
         lAe+y10jxSnXxsKAkNMzdVRp/YysSRfu36Jy3OIrsLl1OJQ/J+AGL9UuFLQd9BsTNrlG
         jHnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvIN450+VV4gRSnkDarnOMf1Df1y6SQwFp+pJ/us8+lSF0qdSwcaR1lTCPuyJP8drrO27IFHRN7WuNIf7zWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzXsDHT8yOIIiM10SGBi+kl3aWwVb2v/dJywMZ72dyXU6L8Uk
	WQPJ78YmQS7+Cfma9L+w1zj9+YhoQ/Ymv6cBOFgdi3sTmRAhkJbSrcp8
X-Gm-Gg: ASbGnct8tT0oRHh0do7XDu9W7NzvBqBhJzhLf1nPvI/RG8ysVN5J31+IlniwffYVQnE
	k3HSoGYs90vUsQTWFHVLz19uLIWbBIzKGE00OBMd4e2cx7u6apwMd9EXrpKSe8JXiC481oizdKp
	s/ESZyAv117N6j5Zx4OwCbsqRNvcOXUByWkqGf8RhulDHo3r1sYYb4AmRkngRUnIBUVM+XV7aE2
	BRYvHQ09Wh82u0koLAdCscrpQMzRbm9CDizHOHcxI3eNjj52BvFwa/B/Aqwva9ybXueaBzbZDnq
	O7JjrVlrY9SLLjWB5vstrzUs1K97DyASEjqQsNzystDX73NwVcRdp6T1iPVZST9d1LcnBl9ex9W
	HgNts4Yj3r+N7EQ268xjLsfsKt3S+YdqVHGtz7niCYf+cSV9PNfzP+LpCUxSqV7ioS76R824hLi
	s7FkpQHxhVAMmBbnhV8fh0gx/FOetdOmE27xDJazVc16gYb4Y=
X-Google-Smtp-Source: AGHT+IFjedik0MVZzW42ZeTwxhByD4S2tb7wikp1vYXQLqeLHay/lDx+CGiXprGCEhGGKNb5OAwYAg==
X-Received: by 2002:a05:600c:638e:b0:477:bcb:24cd with SMTP id 5b1f17b1804b1-47717e30a86mr4189795e9.22.1761587441185;
        Mon, 27 Oct 2025 10:50:41 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:7ad3:93f6:d1b5:4923? ([2a02:168:6806:0:7ad3:93f6:d1b5:4923])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd02ce46sm179949795e9.3.2025.10.27.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:50:39 -0700 (PDT)
Message-ID: <97ee879e4f80c3746f6b79ef5ed1d45f452f8ce7.camel@gmail.com>
Subject: Re: [PATCH ath-current] Revert "wifi: ath10k: avoid unnecessary
 wait for service ready message"
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, Jeff Johnson
	 <jjohnson@kernel.org>
Cc: yannick.martin@okazoo.eu, andreas.tobler@onway.ch, 
	mathias.kretschmer@fit.fraunhofer.de, linux-wireless@vger.kernel.org, 
	ath10k@lists.infradead.org
Date: Mon, 27 Oct 2025 18:50:38 +0100
In-Reply-To: <20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
References: 
	<20251027-ath10k-revert-polling-first-change-v1-1-89aaf3bcbfa1@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-5 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-27 at 09:49 +0800, Baochen Qiang wrote:
> This reverts commit 51a73f1b2e56b0324b4a3bb8cebc4221b5be4c7a.
>=20
> Although this commit benefits QCA6174, it breaks QCA988x and
> QCA9984 [1][2]. Since it is not likely to root cause/fix this
> issue in a short time, revert it to get those chips back.
>=20
> Compile tested only.

With this patch on top of v6.18-rc3, the following device works again:

02:00.0 Network controller: Qualcomm Atheros QCA986x/988x 802.11ac Wireless=
 Network Adapter

Tested-by: Klaus Kudielka <klaus.kudielka@gmail.com>

