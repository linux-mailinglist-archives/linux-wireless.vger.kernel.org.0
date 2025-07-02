Return-Path: <linux-wireless+bounces-24778-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2EAF6356
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9150521EA6
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 20:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F411E489;
	Wed,  2 Jul 2025 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A/8w7MgX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE02DE717
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 20:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751488273; cv=none; b=PWxBpQXCZG7QZre+WWp+bHMLNaoYuYkUcCIRvSughhr43V/8jd+ENRyQIlYnd9tChxQTVKy8UVUuijIF7187Om982gX8KqcpUoc1V1tZVZ6HizJmPQRvTUMr8I2DDZVxN//5zmHwj4LNi/Qj//+7OfAxSWwg+JqlNOFlv01X3D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751488273; c=relaxed/simple;
	bh=K6miw7sbzNPxUDk13yZx1t9xKxmuEYq6bas2ceSvc08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSjt5ww7OJDedWzPjMabU8h1ErzLPu2DKQHjjMEmONGdj/xB5UYhM556pE4CqEPiPIaUjSQaurAyaJ9YRROJ6du+cUoC8Ua3U81DKswTJdj5Vx500TjqaABeDmYpm1DZvDfZUsM0wUWVI+5PPdJq0ASr35FMay15X3IHQIZ5Zdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A/8w7MgX; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-610cbca60cdso3017835eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 13:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751488271; x=1752093071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DxP8oLw+K/WoH5QKOF7Rw2VCFpcI7Pct1Qdk7h37Mpk=;
        b=A/8w7MgX2ju9cse6Xl4NR1ufcAobZrADZQehRpvqv8zFF2CzYbJU8Z5MU7JuSLI4t4
         rtfa9ToHp3yhGD+nF49/L7htgJ4+aB0gW5x4McxTPYvSWkKugW1zFNGgR+Ed9ku4CW8B
         sf+YRh2C6agtzaRSiGlYeKS6voOjFowpHU2Fsld8nTYc257BbOoroba83BRv6HoErDtS
         yzffUEygN7y6wb+KqEyvJzs+3MaBAKu6ajIHlMcfYff47AOEjoJBCTN+l40RJqw43jLk
         AaW8S8ROsTkNUuWx7Xo7k/Nydsr4MAndIUraSBlOvVK0NP6PbMKWjDM6EVJORMx2rpf1
         lQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751488271; x=1752093071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxP8oLw+K/WoH5QKOF7Rw2VCFpcI7Pct1Qdk7h37Mpk=;
        b=Fz/bRInz8gg7N6n1pdZQZD7ID80LR71ey1QpeGNhnpoTA09/IADiDzzOpkXvxaA0HC
         y5PneYgaOGHGzHvZT0NGjI3gYfyEIon2XdKyVzTxUZOiv7NpQeD2Bw0bGuKtMKraquN6
         Rxe6PQeJFrcgX/KxCgbgOALdK1djR4+0G5Q2IEYmEXlg9CkyYa6lu60kHBV/SMR7j//j
         7ccspzmSbWdmToWL5W+GjjXLA2PN2qIGJU8FTtZb1MW3/IlCykvPHawF+OVFW6PXiT/S
         CCCvT4s+Du9AK/eBYZKGUFheGdFzJxk+1Eu8cvO+8GpYmmsjthzY1UDNcFq+Cyj0QJGZ
         Ikow==
X-Forwarded-Encrypted: i=1; AJvYcCVHzovAExb92vVrJ9MGyTsgh5aVPFbTCxJMUWCG8iHvu2Xsro33uA5FdDXPYANSO4bJ2cgG3YYryt7NJjCwlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXAwF0qqeOSXf6A2ViYIK0P1fESYxsPhK2UcWNV5tciIOIXtc
	IzM8SsrMimUkQTZtQsCwxNGT5QNNseZAzvcRAW8cvPcQZ0txmiMUTQkkxz+yHIotCjWaLrMEflO
	DvHBo
X-Gm-Gg: ASbGncuUqL5tQnf5t9OeKdZZ91St4NcInaaOwR7CuhAqgc5L6TeDQwSZXFdIBHTRJiS
	yv704KMr0hyEwyQvg1oVobaVRpZzOBmcYG396aN9Evj2bu5KpDe/fXsPNUsDXUoY6mvu9XEo3Et
	7/8XhygGvUTyarTjv0VtokUOnLxpXAgugPxitxnojZlsmzsW6qc9+QzO9TqNlmb2ShY/x8oaD+2
	tg5W30tpuqQ8dZktYUIeY8MJVBdzU3ryRBmLiO3k3szLUpYYjl2nXfryTUesjY11qjeBqewFFey
	vz+JLDRHepTL5BC1Uz9hDEU/zfHR9EfE3TzgVqRzLpclAa263FOwKxVRaX5ynTUq444n3g==
X-Google-Smtp-Source: AGHT+IHWVf6uaMOPj3PPQDVaRHjqTQ7LaMlYeTrBiFxloldJf9Nhz9IxkILSTFQdDWd8e5A3OTGJTA==
X-Received: by 2002:a05:6870:b603:b0:2d0:4a2c:7be6 with SMTP id 586e51a60fabf-2f5a8c62e71mr3709232fac.30.1751488270999;
        Wed, 02 Jul 2025 13:31:10 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:7056:ddb5:3445:864f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2efd50fb14esm4050638fac.42.2025.07.02.13.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:31:10 -0700 (PDT)
Date: Wed, 2 Jul 2025 23:31:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sarika Sharma <quic_sarishar@quicinc.com>,
	linux-wireless@vger.kernel.org,
	syzbot+4ba6272678aa468132c8@syzkaller.appspotmail.com
Subject: Re: [PATCH wireless-next] wifi: cfg80211: Nullify freed pointers in
 cfg80211_sinfo_release_content()
Message-ID: <a274f5b6-d6d6-48f8-adb4-e081040cb0a1@suswa.mountain>
References: <20250702162531.2705566-1-quic_sarishar@quicinc.com>
 <c7d5adbc4fe45c0bc55567f9d1b228d169dd9097.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d5adbc4fe45c0bc55567f9d1b228d169dd9097.camel@sipsolutions.net>

On Wed, Jul 02, 2025 at 06:41:31PM +0200, Johannes Berg wrote:
> On Wed, 2025-07-02 at 21:55 +0530, Sarika Sharma wrote:
> > Currently, cfg80211_sinfo_release_content() frees dynamically
> > allocated memory but does not reset the associated pointers.
> > This results in double free issues in nl80211_dump_station(),
> > where both link_sinfo and link_sinfo->pertid are released twice,
> > once after the send_station() call and again in the error handling path.
> > 
> > Hence, to fix accidental dereferencing of dangling pointers, explicitly
> > set the freed pointers to NULL.
> > 
> 
> Do we have to fix it this way? It feels like perhaps it should rather be
> fixed by only having one call to cfg80211_sinfo_release_content() in
> each path.

That was my bad.  I suggested it because the diff from changing the
callers was a bit larger.  Technically I suggested just memsetting the
struct to zero, but that approach doesn't work because of
batadv_v_elp_get_throughput().

Re-working the callers is totally doable.  It would look something like
the diff below.

regards,
dan carpenter

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 70ca74a75f22..2066aefc05c7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6996,10 +6996,8 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	int link_id;
 
 	hdr = nl80211hdr_put(msg, portid, seq, flags, cmd);
-	if (!hdr) {
-		cfg80211_sinfo_release_content(sinfo);
+	if (!hdr)
 		return -1;
-	}
 
 	if (nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex) ||
 	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
@@ -7247,7 +7245,6 @@ static int nl80211_send_station(struct sk_buff *msg, u32 cmd, u32 portid,
 	return 0;
 
  nla_put_failure:
-	cfg80211_sinfo_release_content(sinfo);
 	genlmsg_cancel(msg, hdr);
 	return -EMSGSIZE;
 }
@@ -7530,34 +7527,38 @@ static int nl80211_get_station(struct sk_buff *skb, struct genl_info *info)
 	for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
 		sinfo.links[i] = kzalloc(sizeof(*sinfo.links[0]), GFP_KERNEL);
 		if (!sinfo.links[i]) {
-			cfg80211_sinfo_release_content(&sinfo);
-			return -ENOMEM;
+			err = -ENOMEM;
+			goto err_free_sinfo;
 		}
 	}
 
 	err = rdev_get_station(rdev, dev, mac_addr, &sinfo);
-	if (err) {
-		cfg80211_sinfo_release_content(&sinfo);
-		return err;
-	}
+	if (err)
+		goto err_free_sinfo;
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
 	if (!msg) {
-		cfg80211_sinfo_release_content(&sinfo);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto err_free_sinfo;
 	}
 
 	if (sinfo.valid_links)
 		cfg80211_sta_set_mld_sinfo(&sinfo);
 
-	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
+	err = nl80211_send_station(msg, NL80211_CMD_NEW_STATION,
 				 info->snd_portid, info->snd_seq, 0,
-				 rdev, dev, mac_addr, &sinfo) < 0) {
-		nlmsg_free(msg);
-		return -ENOBUFS;
-	}
+				 rdev, dev, mac_addr, &sinfo);
+	if (err < 0)
+		goto err_free_msg;
 
 	return genlmsg_reply(msg, info);
+
+err_free_msg:
+	nlmsg_free(msg);
+err_free_sinfo:
+	cfg80211_sinfo_release_content(&sinfo);
+
+	return err;
 }
 
 int cfg80211_check_station_change(struct wiphy *wiphy,
@@ -19558,11 +19559,15 @@ void cfg80211_new_sta(struct net_device *dev, const u8 *mac_addr,
 	trace_cfg80211_new_sta(dev, mac_addr, sinfo);
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
-	if (!msg)
+	if (!msg) {
+		// This bugfix needs a mention in the commit message
+		cfg80211_sinfo_release_content(sinfo);
 		return;
+	}
 
 	if (nl80211_send_station(msg, NL80211_CMD_NEW_STATION, 0, 0, 0,
 				 rdev, dev, mac_addr, sinfo) < 0) {
+		cfg80211_sinfo_release_content(sinfo);
 		nlmsg_free(msg);
 		return;
 	}
@@ -19593,6 +19598,7 @@ void cfg80211_del_sta_sinfo(struct net_device *dev, const u8 *mac_addr,
 
 	if (nl80211_send_station(msg, NL80211_CMD_DEL_STATION, 0, 0, 0,
 				 rdev, dev, mac_addr, sinfo) < 0) {
+		cfg80211_sinfo_release_content(sinfo);
 		nlmsg_free(msg);
 		return;
 	}


