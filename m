Return-Path: <linux-wireless+bounces-20670-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1B2A6BD03
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3810918817FB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16780C02;
	Fri, 21 Mar 2025 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsbEahx3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F46C18858A
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567617; cv=none; b=Wec+q/t/f0bDG6n+dhf4SfUgJby7YMDlojm3AKW2zyo277AmYTJUxZtlBtcZENGjvW1nsIiLei/ubCKv3dEAe1F8+C35MOYg8hZjoWmWblY2OuKwoPfwnb1oIDsou8hFjKFqGQ3UoiarkaDqG8CTVps21kUbeph40Ohwnoa3rwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567617; c=relaxed/simple;
	bh=Au9U1ucm9M5ozgCKdtgD6v01IXeSd3Txu+uwKw8/sa4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RhEZdWE+cQRnoy4DfMCrby3995JBufsUmxEX/EkYDjMViszWY4ZVMgM7HwZ4M31zHWJuxrEQMLRzzkLVdO7p4NHfzQ30b5+LuXkMlgqNTJ86po9tUeYFgdNs1kQsFN1BPx94NOZfBK0RmzqmctDUaofc29cfZTqsjLgma4Xk3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gsbEahx3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so12822595e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567614; x=1743172414; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adFZmJLQKFx2XqizsrAQWSoaZBuWMbRGXmjBb8zBkJU=;
        b=gsbEahx3IYsHM3GqF+4LePfdlamMwQ/Z8pk478my0fYp/prPxF3QHTtMSaCHSZkRf7
         R1l2+egH+vQWImghSt/E86aR8oNpD8a8yoFSVUv9C+x4L079+ojzhLdMpIti5U7A1g4M
         stE10HvMc8sbPtIfnkXb68NGkitNll5yxNmjrk7lTArm9XQc8k7czKRaesORPdxfh90e
         ynsau6mZV5YIzz2+z+GxBxrd4jyQAim1IiTnJk/tuTQvUEaeJaSqxX5OXf5q2eEmsugK
         j1M3RgL35X573mhBu0Cu8FTu4tawm2a9AJlulTSyIwKQJhkY+jSM36f+5D0oCJIVV4gv
         5rhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567614; x=1743172414;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adFZmJLQKFx2XqizsrAQWSoaZBuWMbRGXmjBb8zBkJU=;
        b=cCtnifvLmw3PeRHQMZKzPrKTfqPBbUA5xgfpz68M9Oin85C8g+4BNtJUqFy7Hdl+a4
         VSe3TfxmII55ix/eXFfL3twSRkfCTY1M3H5hLRnBcIpI2TOF5496orVFjrRm0C7G7x9s
         sQuuWRhOaygYyAaySgrYOAqpAP1Thv5Fbf+n2kYAwDCxDqxnifZqPtJbTcur2VvDRXFT
         ywfsTDTFJxbjdU0f1JE9cziFjQhMlTTvIKeAdVtr1FipTzck8mOQZT++eQNwj/x+dUwB
         Wbb4/9BuQBP8p5OvBwwJIZLXC+BgQJjF7Ln/FbaBOlOEZk6IAIYCpEGipQNmTxGEJvno
         UFtg==
X-Gm-Message-State: AOJu0YxnmnxwtNtVLMgqLL2akFeS88V1lD7yTAnXX+JzxxLYuEZUPmxy
	pqGk8mQz6nJQgTD/5GVQemD2LBPo+NwCeP2l2+3Na/II/XzaY2WabBSAPRjtsbs=
X-Gm-Gg: ASbGncvC8/L8bPUEPd5K2QDXNbgmJ2RsEPPND6QjoOcjrb4Xt9vKJdeNd8dvyPUf6lh
	4WMzSaproJ5LVaAcVycE3YgrkSOOiNxnBrufSRYlkdeb0nwkklp55Rgxax0+6bnugSuSBAYiv4A
	orEE0DDuTSOXPrwWXp1lBqEX+wfzLSZOK3rFAG4fVaAHCl5SBkxUh8jVA9qpYYhzEaCpCendNs/
	fhlzNbsvB2ITSQIZsj4tUcSXphQerP7HtVhHhw7W+NPVxrpZ0B/nEeqOMuJUQa3YEBYyPCMr6Fv
	EzCfAVpWjzHsZFsPD4qOaQBHx2uv7BT/65llVWczKnM8Z85pNYz3P96D8wbd
X-Google-Smtp-Source: AGHT+IEQYzpu2so8XX8P3XLbdEYx3pHR0HTy7KQMupXaaPxmsyyZx2ggZsrMFgeKU+LL76EUOG6V2A==
X-Received: by 2002:a05:600c:3591:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43d491b708dmr68646465e9.12.1742567614375;
        Fri, 21 Mar 2025 07:33:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd2704bsm28339255e9.18.2025.03.21.07.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:33:34 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:33:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7996: Rely on mt7996_sta_link in
 sta_add/sta_remove callbacks
Message-ID: <f335328d-8554-401b-83c2-36e8d7668a62@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Lorenzo Bianconi,

Commit dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in
sta_add/sta_remove callbacks") from Mar 11, 2025 (linux-next), leads
to the following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7996/main.c:1023 mt7996_mac_sta_add_links()
	error: uninitialized symbol 'err'.

drivers/net/wireless/mediatek/mt76/mt7996/main.c
    984 static int
    985 mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
    986                          struct ieee80211_sta *sta, unsigned long new_links)
    987 {
    988         struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
    989         unsigned int link_id;
    990         int err;
    991 
    992         for_each_set_bit(link_id, &new_links, IEEE80211_MLD_MAX_NUM_LINKS) {
    993                 struct ieee80211_bss_conf *link_conf;
    994                 struct ieee80211_link_sta *link_sta;
    995                 struct mt7996_vif_link *link;
    996 
    997                 if (rcu_access_pointer(msta->link[link_id]))
    998                         continue;

What about if there are no new links or we hit the continue on every
iteration.

    999 
    1000                 link_conf = link_conf_dereference_protected(vif, link_id);
    1001                 if (!link_conf)
    1002                         goto error_unlink;

error code?

    1003 
    1004                 link = mt7996_vif_link(dev, vif, link_id);
    1005                 if (!link)
    1006                         goto error_unlink;

error code?

    1007 
    1008                 link_sta = link_sta_dereference_protected(sta, link_id);
    1009                 if (!link_sta)
    1010                         goto error_unlink;

error code?

    1011 
    1012                 err = mt7996_mac_sta_init_link(dev, link_conf, link_sta, link,
    1013                                                link_id);
    1014                 if (err)
    1015                         goto error_unlink;
    1016         }
    1017 
    1018         return 0;
    1019 
    1020 error_unlink:
    1021         mt7996_mac_sta_remove_links(dev, sta, new_links);
    1022 
--> 1023         return err;
    1024 }

regards,
dan carpenter

