Return-Path: <linux-wireless+bounces-7392-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E9E8C104A
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 15:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53CD285688
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 13:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5EA158D98;
	Thu,  9 May 2024 13:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mS7R3KLI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4231527A8
	for <linux-wireless@vger.kernel.org>; Thu,  9 May 2024 13:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261088; cv=none; b=V8nMtr0HfejcbE5s/6Qqm0l3zB6Sp54KL1m9eS+zLnFc7StQSBK8oTjsS3g3bcjbvVqZX8RMBu7YQXxsMCHAU4Oyd7//SKVdeC6TZQnH3u75L4x9cq0mmO9Wm/w0QUBZuf+hxR3Wone6KsJeyIF8xwIVNqM7664fuO6wSbGBDdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261088; c=relaxed/simple;
	bh=626m2qpeQjqWnVXeSKj7LeuNEjrKycPa2kGklRBPCwM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VXVmMrc666maFfMDVo712YF0PDasdgE/xcMJ88hFhMA+TvcjRS9g8cRb8lippA4/M8LrLN9VP0gVDSnON8VV9j//DC/ucDCjhVe0mrUPXRYAVoWzdXlu9KE58jxAVYmf9N5kInG+aQYxAxyQD89DDd8mtQbMk4xerSxi1A/2vLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mS7R3KLI; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59ae3efbb3so91416566b.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 May 2024 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715261085; x=1715865885; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fP5JXxPWroaWZ4ElgE1V0xgV/CMoNsssFg+WGvRFV0A=;
        b=mS7R3KLIH8eUGt0hqCE2Pl6pyNugcjsdzcCRwPXQTM/T49B6IOIiYl25qSIO5E2Nua
         aO1M5XzyCKC5rCIdw+4GAMploIjJEF2xDhc7sw++BSUKXvcVoR6v1NpL5pVd2C0D1WV2
         SPy4Ulwow4yW8rgtngcebn4Lz+wHxbwDATUAIbRGtVSqTzL+TGr7FYY/TA6IQV4DKtfr
         Jz+O14fyVE4KP/sOCMmxSTlR38fDCL6PyEuRlr06t9BsAwlNb7H4tSN3vhlAQ8HpfBDT
         Zg1ZKUpy1SAn0xbLau4dhN7RGRkAX4NZGKqRz3wQ1R9JBcHd3FTGwqCm6Wf2QE0Cu9rM
         sq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261085; x=1715865885;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fP5JXxPWroaWZ4ElgE1V0xgV/CMoNsssFg+WGvRFV0A=;
        b=bBjARfZA1doQ0qHi5c+6qAvZVtT0nm9ej1vv9fL2RPzPR1gyP9adrlg11/bHosX9zg
         dkR5Nie8cTM4Oyp3Yh2s75QrqbGyf0bl03mIAhp81BqHl5+yuQFLB5t/yRRlAxE7wLNO
         s6dDjZhcNIBSTi0o86i/5fwNVjxOOmXXirNvhFOknE9oSqPueqxYN3ess9H84BO/8yht
         yXjauzh+jD1B4SU/njd5NGrwAwSyEs1Mnt7aiNtJmEuPo79Mq9h6ZbkQgXJSMlpWZSVX
         ryI/OUTp69M//RC7PvbsLO/DOsiuhBuNPP3pbKW17E0ov1/VRuszPBd9fTD1qyUtKFfg
         x2JA==
X-Gm-Message-State: AOJu0YwLiPwSwhj5mpW6hizc/xLaVu1mPXcKRIpSQDNHzzj9zoOxVDdT
	lZaognyv9JxhJ0TaAOUGRARrx5x4x/+D2EVYtHn6Rmy7J/HWOQ+K2eE8jKC6QhI=
X-Google-Smtp-Source: AGHT+IFcj5BFLeqktGrws007uF8xJPh9RqLcrWccr6Z9fHyvy8oMiFGFPpcRSLlSWZfnNHx0iGW1OQ==
X-Received: by 2002:a50:d7c6:0:b0:572:20cb:475d with SMTP id 4fb4d7f45d1cf-5731d99b894mr4884672a12.7.1715261085042;
        Thu, 09 May 2024 06:24:45 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfb83sm696188a12.46.2024.05.09.06.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 06:24:44 -0700 (PDT)
Date: Thu, 9 May 2024 16:24:39 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: alexis.lothore@bootlin.com
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: wilc1000: convert list management to RCU
Message-ID: <3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Alexis Lothoré,

Commit f236464f1db7 ("wifi: wilc1000: convert list management to
RCU") from Apr 10, 2024 (linux-next), leads to the following Smatch
static checker warning:

	drivers/net/wireless/microchip/wilc1000/mon.c:236 wilc_wfi_init_mon_interface()
	warn: sleeping in atomic context

The problem is in the caller:

drivers/net/wireless/microchip/wilc1000/cfg80211.c
  1527  static struct wireless_dev *add_virtual_intf(struct wiphy *wiphy,
  1528                                               const char *name,
  1529                                               unsigned char name_assign_type,
  1530                                               enum nl80211_iftype type,
  1531                                               struct vif_params *params)
  1532  {
  1533          struct wilc *wl = wiphy_priv(wiphy);
  1534          struct wilc_vif *vif;
  1535          struct wireless_dev *wdev;
  1536          int iftype;
  1537  
  1538          if (type == NL80211_IFTYPE_MONITOR) {
  1539                  struct net_device *ndev;
  1540  
  1541                  rcu_read_lock();
                        ^^^^^^^^^^^^^^^
The patch changes this to disable preemption.

  1542                  vif = wilc_get_vif_from_type(wl, WILC_AP_MODE);
  1543                  if (!vif) {
  1544                          vif = wilc_get_vif_from_type(wl, WILC_GO_MODE);
  1545                          if (!vif) {
  1546                                  rcu_read_unlock();
  1547                                  goto validate_interface;
  1548                          }
  1549                  }
  1550  
  1551                  if (vif->monitor_flag) {
  1552                          rcu_read_unlock();
  1553                          goto validate_interface;
  1554                  }
  1555  
  1556                  ndev = wilc_wfi_init_mon_interface(wl, name, vif->ndev);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Does a few sleeping allocations.

  1557                  if (ndev) {
  1558                          vif->monitor_flag = 1;
  1559                  } else {
  1560                          rcu_read_unlock();
  1561                          return ERR_PTR(-EINVAL);
  1562                  }
  1563  
  1564                  wdev = &vif->priv.wdev;
  1565                  rcu_read_unlock();
  1566                  return wdev;
  1567          }

regards,
dan carpenter

