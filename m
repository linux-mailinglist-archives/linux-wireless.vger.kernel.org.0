Return-Path: <linux-wireless+bounces-29552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB258CA992C
	for <lists+linux-wireless@lfdr.de>; Sat, 06 Dec 2025 00:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB30430F1950
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 23:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156571F4262;
	Fri,  5 Dec 2025 23:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbemJjlZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRwPt3e7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AFC1CD1E4
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 23:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764975836; cv=none; b=goK8+hIxGUxANDxy+NVGDnI9rjkJ8k8rv+RFihJP+mJ4t5exvvAPO5fGMn+2JXX91tnWf/X3Nmo+VOL2p0Q/GMc0CIbfa1r+pKa2ZR//yP+TDxQX5YxvaTlxjcL1HCURFgBR1a56Sp0uK6EXvWNSwA5WQC62UGVIgOH/7PDRwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764975836; c=relaxed/simple;
	bh=vTpKOaMRavBDUF7YSKblSw9NrqANWs6xAzx1LZpuU+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+bu8NM1nH4Q8HMjnaT8UznUjDEcM+2V+lcGpvAuiDtnLL969Q/+PHaQpAo58CLn9Xvx0Q5Xy7RkCwIX2p7/qLU1DPMUrzAhcTJQjbdqqucaaVg9OtWaHGx7DrNDe3TuzFsivmj/Q7W2OWJRXZco4lUMKQMP/ai4EKxRzvcj5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbemJjlZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRwPt3e7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764975833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hvvbTCEJ4kvrTR9cdqjnG7l7OejvkwDkr22RDg9WJn0=;
	b=GbemJjlZqCtzfMejSDs8P7pzYHn+eWacvarEofERJ96sIZIQWwdEDUqqCkU8Z8qJoCrnRi
	MZ6X2OUo7CQvFCg7qr9VwZ9iEuflZJvReZY+8x+LFK+XcHvNknaC2tlHU84u+TeFKhhPG2
	1KKXlezuEu0UFKOv3Bs8c2n3XH+ubIg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-ncB5swyRNdCthTzT5mlGBQ-1; Fri, 05 Dec 2025 18:03:51 -0500
X-MC-Unique: ncB5swyRNdCthTzT5mlGBQ-1
X-Mimecast-MFC-AGG-ID: ncB5swyRNdCthTzT5mlGBQ_1764975831
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-295915934bfso36334415ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 05 Dec 2025 15:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764975831; x=1765580631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvvbTCEJ4kvrTR9cdqjnG7l7OejvkwDkr22RDg9WJn0=;
        b=SRwPt3e71b+inzoyLREP4IFyK1yJTlIIbQVTrU3v+Z6PNfBFXY79/3CX+4AVE6BMbG
         Tdj4dMFqpUZop5toS1EDZySy2EwjBmsNJLwQXl6tkWxWwf+IepeSQhZDjyWrGO2UtmEd
         QviG/gspkgbPvH3ezrnGAqhUdqSjmy9PXvPechnEvsgFZOuc+aeIvg4oz12sIS2NQV1t
         m0I+5XI7ukPuiosWgN7vUjMYeNbm4fBGMppgBjVLy9upZmcJ4VHwUheNP0ivEnlmQHsd
         g5m5PSeDSy0vILDmwW95W0wTcsl5NsHXP8NcDQfAmKHTKIUt1x7f12bcJXbdovfA0TMA
         cVHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764975831; x=1765580631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hvvbTCEJ4kvrTR9cdqjnG7l7OejvkwDkr22RDg9WJn0=;
        b=qp399ioAmghKwtHd7YNh3/uHLYQ0Of0Kzwebx0CXDH6OeV8hBGVFoNaakQOGk4r2C9
         +CM55GhMNo5aaOswS4AWlGSS7ABCFIMHaySVgZwhfUxka9okKkoxM5zl3J5ofQWPMJJ0
         xFoGcA2SaVVNtawMefODKLDGaYXOod3JFEjerVWYS1zD2caoWkvVmQVcHdkcKcX21cWe
         kDh0NsNHmjIMjHx+2RlKlK7HceFDrv7CZz2lvx3h4MzvUMK275wLzcTLDedNy4XWFjig
         xybZzFAzYSLY6MUBBhyAyjGmyTwxtcDSQAf02fVRMQqAnDgrqieYSRIUpAw2PTfPDJnp
         g/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUHJrmSGvyZ0NUcR2XYBtXcFre2Cczfy0Rtk/RR6EQU0ScMpavFWkBSrK77a5NZrrTLITy0GsfvS+SgnSOEfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwalMigYfLudeK2TesqjGEAO1qrLFaVhHYKCcOiInqaK1lYxlQv
	Snpy6T35pxG//NJ+U26QcVUOwjRmbpxZtQZkSpXHPFKo6of1CinGogc1IcMvHYa3c8Y176NfjPB
	+Y6QYmLkdguXrhU0341K7mTHCXhyCqvkjhmWj+wHbPYiaVXFCJvSCWmRLw+dpclEyaTQ=
X-Gm-Gg: ASbGncsdLM00Ihl/DWocx1WZI/euwPkOjLM1ZvqjtHTY2n7gHwleZ0tCA5fmju/FQkM
	g9AczncyjLkcKTE2RKkTfYdkNqhOE/oNEMXeIV/xvbtoK3Pfg2wKb/7rz+TUNYJeDmdA4NUSPDI
	ooGh38RHarNamfkHBiZ0vl29GsmrLdUafEysRaZkb316SUI7E/Xb2+HJGax+3s1zyPB76dG8Amo
	EG5+CSpjbhezVOh9KrroHQnQHuwp99K11ukWJf9BsvS6/DkGzS6L/8TPUUArd5UWA17JWA4HZuN
	h35tEsWl6c1GJD5abFf3ZdrC0PpN1Lkjj3x/BNvzJhUH5LizfTtkIms0myfSSmVWOwuMY5a9XDP
	D9gdtmS4WjhypdSUjcSe9PFCF3oeIEWL3YHwgdg==
X-Received: by 2002:a17:903:24d:b0:295:39d9:8971 with SMTP id d9443c01a7336-29df5472249mr4856375ad.1.1764975830907;
        Fri, 05 Dec 2025 15:03:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHsUVtC8I+h/q59YIorfhKcI4FHw45d1SMPdI5SNKARYWQjuWkSeXyb5KLiNiL1Awl5qsKEA==
X-Received: by 2002:a17:903:24d:b0:295:39d9:8971 with SMTP id d9443c01a7336-29df5472249mr4856165ad.1.1764975830498;
        Fri, 05 Dec 2025 15:03:50 -0800 (PST)
Received: from dkarn-thinkpadp16vgen1.punetw6.csb ([2402:e280:3e0d:a45:3861:8b7f:6ae1:6229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeae71eesm57758725ad.100.2025.12.05.15.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 15:03:50 -0800 (PST)
From: Deepakkumar Karn <dkarn@redhat.com>
To: johannes@sipsolutions.net
Cc: dkarn@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	shaul.triebitz@intel.com,
	syzbot+5bb5f06f99924ea0cf86@syzkaller.appspotmail.com
Subject: Re: [PATCH] mac80211_hwsim: fix divide error in mac80211_hwsim_link_info_changed
Date: Sat,  6 Dec 2025 04:33:44 +0530
Message-ID: <20251205230344.326220-1-dkarn@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <717b98574a9037a5e81c929f97cc1258e00ee2f7.camel@sipsolutions.net>
References: <717b98574a9037a5e81c929f97cc1258e00ee2f7.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 05 Dec 2025 18:39:49 +0100, Johannes Berg wrote:
> Seems like we should not let userspace do that, to protect all other
> drivers too, not just hwsim.
 
As suggested, we should provide a zero-value division check for other 
drivers as well. I will investigate other places where divide errors can 
occur due to edge cases.

Please let me know if you meant something different. In the meantime,
I will analyze other drivers for similar cases.

Thanks,
Deepakkumar Karn


