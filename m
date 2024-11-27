Return-Path: <linux-wireless+bounces-15759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34449DA74E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 13:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9903C28128D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2024 12:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734221FA17B;
	Wed, 27 Nov 2024 12:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQsONPQJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195791FA142;
	Wed, 27 Nov 2024 12:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708889; cv=none; b=OMeSVLVRtyNcqd9EicIyXrJ7PlyiXZnVosKPX0LqXSKZHOLm/V8jdiwQbQIgWvlEC9ROXClswZlQSG9OfUEmevjiq8xI04rPWKVLEykop0pbrLw6w4mFjiN8p9OijXFGKbopsBKr+tkcUOA43N08e5/jVayu7GrlMlq1Ew5dwQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708889; c=relaxed/simple;
	bh=lTNDyMY4THwkTeasv2E7soWYa0M4QXhAsRbC78dOzXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T7zpNcgwg+Pc74fpcY3hYwtDl08hAeQqnfg0vMQIyhsOH4/84fEpk3jpOXADTxnxJ8xZwX6vfq6R9IpGM7/JgM2mbSLXxHZit89WdpN8sIZj/IETw+kHHZZHT+TO8rG14OQxCOMutNMp8wCTTA86haCis94vlgHtGP+UFRs5MTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQsONPQJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2126408cf31so48275515ad.0;
        Wed, 27 Nov 2024 04:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732708886; x=1733313686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sN4/UYCKwnjX/w6HTtGzxERNvG6yJdCYTg0zaHpcLhc=;
        b=EQsONPQJrPmrUREc7x1NasqYrIJInr8CpiBP5AwHlowKquaQ0xk75hxFSQuT2aFq6W
         Yo9PDoQzSd7OCrRr5t8LT4GhOsupg+c2bJohtBnwr27uyJKgQ7TJ4cEF6iHFpSVmH7qp
         kIYzlBzPd9XiA8ogAwMjEbHmmdKZ79dEIaYTY32doWnE1KDQJ/lnDRERujJHj0eUaLjt
         tNd7xd80Js9Fdvl0AN6PbKqilruv7CVPNH8mUDcMjUqNjFol1KVrVT/NWKJhSCIY0jId
         znKj/9AqGnbOz0xO+uBZ5kyAPhuI3OJahIP6FClM5Bks8zf2EFq49CILe+NmX6fRiyX+
         A91A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732708886; x=1733313686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sN4/UYCKwnjX/w6HTtGzxERNvG6yJdCYTg0zaHpcLhc=;
        b=YO2NN73K5l81nxQgubl3Ywi202/VrCnZEIrc+3mJpwoCdrBJdZUN5aQWLwVdTzDavy
         8nKcigtDXtTgZ0GHoXCHO3wuHIBSjIYXLMe21zAf3Q7Hkz+XSJsOUNsx5W2CLM7c5Rn8
         xBaX7iS30aniaSITtk1AbjQlOjqFeOK7dtur0WCRry0sGF1ZufhMHOhnKo+OOOn4Cr7j
         DrhoeYDDSxwheygQuCycg8e2u+XhcQI+Ms1V3bANK5/Qlxo3J1LL/qWuRe8ffq5dHjWR
         Xpk0B3q0ReLZoSDRMXhGfSqwEvrgbfK77+mIm2ED5gzDlHOQLs/cVT/u+p3ZEv35nksE
         VzJg==
X-Forwarded-Encrypted: i=1; AJvYcCUJhjxdVX9zfB7hP/DtvOhI/9Lab87ZcCqDBEHrYLfxxE/8rgNgF9safxFai2ffEH+eAZnX7UK4/UogzACIkfQ=@vger.kernel.org, AJvYcCXac/dot7/6A+OKgXepS+DH2xkiIx9+YV5prUY3iKha0t2Lu4UcvozrcaUKtib0FMf2L/XaER4ZNDqjLXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXF7Eyzheg2gwdp3C+/T7sdew4bTqNnl4AGHAZYdvIyZTCJ30w
	ULXUxkhAclpJIYsfjj6oAx77KWh40kYrYBlZSRQ75FKTtp4b5joI
X-Gm-Gg: ASbGncsJ1Uu1Q52jN1pZEI8T8gYN066DcmwUZIwRfDXYgdpg4nY+5QJEOzAvaYtLN4o
	g/89U3gDET5q8rXvR+elGtm9tElGgcUsWUeIP7w+kLI3HL+CyGxDpiCduC2vx03qTZjiM1HGaHW
	L05AWjOyuZahhZxN+Xy5s08Qam8kdietDR36oNQsloAeSD4Xg/YzLuvuEfnZlT6IE9Q6oMZZAgT
	j2PBBIYinQgO/MGwnPAPl0/Um6ANSA6kHollTELLN5AO0kDnNM0RRudkRY=
X-Google-Smtp-Source: AGHT+IEU2vKSpnu2XaJg/vWlfp9dLeYI801wk8Jeavg+UoypKKB1w/kg64aUyi32uf7+nu7ZgnCBAQ==
X-Received: by 2002:a17:902:ea05:b0:212:e7c7:6bf7 with SMTP id d9443c01a7336-2150108591cmr32135295ad.4.1732708885868;
        Wed, 27 Nov 2024 04:01:25 -0800 (PST)
Received: from localhost.localdomain ([223.72.121.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129db8c404sm101297915ad.40.2024.11.27.04.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:01:25 -0800 (PST)
From: Baichuan Qi <zghbqbc@gmail.com>
To: quic_kangyang@quicinc.com
Cc: ath11k@lists.infradead.org,
	jjohnson@kernel.org,
	kvalo@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	markus.elfring@web.de,
	zghbqbc@gmail.com
Subject: Re: Re: [PATCH v3] wifi: ath11k: Fix NULL pointer check in ath11k_ce_rx_post_pipe()
Date: Wed, 27 Nov 2024 20:00:43 +0800
Message-Id: <20241127120043.33873-1-zghbqbc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6f4037b4-8084-4e1d-b339-274e25f6d317@quicinc.com>
References: <6f4037b4-8084-4e1d-b339-274e25f6d317@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

thanks for your reply

thanks for your help. With your help and Documentation 
I now understand how to write patch change logs.

Baichuan Qi

