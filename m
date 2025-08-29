Return-Path: <linux-wireless+bounces-26865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C495B3BB9A
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D587A21F37
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 12:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BCD317715;
	Fri, 29 Aug 2025 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lvpOdlve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E558314B97
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 12:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756471722; cv=none; b=iYDKpzPQtjWPqTAbxSWIXWPpjI5QKbGrogiyC3/nNK6fGXo1Wiuq8SD6D6Zf0KJnd/Qwr6vnYE37s8G0JCNzMgIiWyfn/Nh6I6HI2SOM3f0rSs3VFfRv2bJ8+9gfDzNX+XCdkeyDuPthLgRuw0TfKt8QemKZZyxp063PDVNeYsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756471722; c=relaxed/simple;
	bh=45DiPpeOM5zx6/4Mw43Vd8Fx93MYiPkCbDHS8+WL5GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZjYNrKgXa3oWNbfJDn8Wef2TK0P8kKVIcbqpbwwfaiwv0zETwsxVmFEfnp80YtMNkpz4Ua9hDHegsMIuet41K7yfimXSJHWQNPgqqnPqCXnmkd2lfk8JZofLvdpVNzcY/vR6qLGF4oMCr3r2201x3SwkTOstR9Mj0DmV/8PKb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lvpOdlve; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ce4ed7a73fso935522f8f.1
        for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 05:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756471719; x=1757076519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0nz5/CZs0S2wdMdQ1/s3IpMYW+S7LKqMEZUzHzH1Avg=;
        b=lvpOdlvecnmDicKc5/zB/BVycefbX0gIITsiJXiIKoKT7udqSx5OLN3wfBDJ0TujMq
         EJccZKf6CNeH08L0hgtjb77qhEStPnfY/Jb/s8gJ4lMMW1JqaUn+eNTCxT5CrcWRfsFC
         Iud7UvCDkVjQ2ogAYQCBT8Oa1KcOvwEQfun1rtinaxwLGwM+xIKUoMOH8omzeFzfSPCS
         3NL7p5InKq8I+3vlYx93D2UKIx5gosHsglkf3pyx8rsE+mN+7bYHvbsFUN/dHFwjIO4Q
         W8VXtu483iZbNUW11hZqU33rX+B4ORKCJf+vXLA34pujD8FHPeEjpzd5CfVuszLedcb7
         Wklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756471719; x=1757076519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nz5/CZs0S2wdMdQ1/s3IpMYW+S7LKqMEZUzHzH1Avg=;
        b=gkW3iB7CvUhoRSwofA2qxYw4bVzRGIAOHlH+hsofAuIWreVWXQy3EIkKFMFMbN7Osu
         d8v/+MLsK8gqip+UqP0iaFO9N+jUE/FjCJB/vc+ePbMPezw8kiBrJpzMHE89Mk0P0YdB
         sb4d3yEuws6uzvtdQ1Ck5JIawrviSs+alauoja97FEGlhg38mdk/nddKxO0c7XAy//BM
         3dZgWjh6AE4D3ZBmVOLVk0WyJNHmoRycmS2IuZt19kZMbB+K3u9SuhiTats5U4/3vVQ3
         PqrQerzC5Jxk2M1U90RzzkuGcdewfxrLA5dbpCnZaY11nA36vjH4UbBQYCXGHnpp4nje
         Zs1A==
X-Forwarded-Encrypted: i=1; AJvYcCU4FnUquK9BIm1s1Q40zopX8aDC11g+kO81u+VZh+QOy+uh89V6n56+hXl1vCykeWnWBBKvJXoBpFv6RABBjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLR5nCgQUCkjkQK7jpHuKr+LlWX3kPhIt3WIuKDR1yQOKsHeEO
	cuclkzJR83Ug97ybSzEZRv2yBchWIiSBmfbSjGPQuyy4f5gBcWxY/wyPc3/xclKhzbs=
X-Gm-Gg: ASbGncsUb6J9Go/tdYrf7K9/5ce1qbS1pPX1+avZtjIEQpnaOffFyebIbjKW0p8Er5M
	APmZ1IVH8d3+PfH0Fmb9mwbWrwi+tHQsVUGtBqS8yqJkqI63wd0IiYJ3DIf8ymH7IVp74o5rv+t
	BE6rWKdr4Q+DlvIJ52hqGobqexwSNMXcv39VbAfYH2pR0UAVcWMQdoSYd8JddEli7D/Sf+eH6aW
	e0bYmqQWXcwUQCvK0i/JqGDgMrceTr0hq9JfDiu9RRbGzdq7se4dhVmlv7Ksi5QLlPef5I4qcRA
	Yp/+sR70ZNQLW5BI7s6QsDBNh5gZC8u27sPJgKmAv41LyPXsdIbI9Mv6RPYyzx53bAlnk59Dy9V
	dlTIHURZmmVf+KZpNtbYrXnyTrWc=
X-Google-Smtp-Source: AGHT+IGAaopXDShG3tR3uCjDbASluxlUiq9mt0YUEy9CsaBbmtN4hEpvIXepYAQBzAO18uaZZewA0A==
X-Received: by 2002:a05:6000:2f86:b0:3cf:1249:8048 with SMTP id ffacd0b85a97d-3cf124984a2mr2541414f8f.59.1756471718819;
        Fri, 29 Aug 2025 05:48:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d0f85c287fsm1493893f8f.52.2025.08.29.05.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:48:38 -0700 (PDT)
Date: Fri, 29 Aug 2025 15:48:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Solomon Peachy <pizza@shaftnet.org>
Cc: Johannes Berg <johannes.berg@intel.com>, Felix Fietkau <nbd@nbd.name>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org, libertas-dev@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] wifi: libertas: cap SSID len in lbs_associate()
Message-ID: <2a40f5ec7617144aef412034c12919a4927d90ad.1756456951.git.dan.carpenter@linaro.org>
References: <cover.1756456951.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756456951.git.dan.carpenter@linaro.org>

If the ssid_eid[1] length is more that 32 it leads to memory corruption.

Fixes: a910e4a94f69 ("cw1200: add driver for the ST-E CW1100 & CW1200 WLAN chipsets")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/marvell/libertas/cfg.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 94dd488becaf..caba7491cd5a 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -1151,10 +1151,13 @@ static int lbs_associate(struct lbs_private *priv,
 	/* add SSID TLV */
 	rcu_read_lock();
 	ssid_eid = ieee80211_bss_get_ie(bss, WLAN_EID_SSID);
-	if (ssid_eid)
-		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_eid[1]);
-	else
+	if (ssid_eid) {
+		u32 ssid_len = min(ssid_eid[1], IEEE80211_MAX_SSID_LEN);
+
+		pos += lbs_add_ssid_tlv(pos, ssid_eid + 2, ssid_len);
+	} else {
 		lbs_deb_assoc("no SSID\n");
+	}
 	rcu_read_unlock();
 
 	/* add DS param TLV */
-- 
2.47.2


