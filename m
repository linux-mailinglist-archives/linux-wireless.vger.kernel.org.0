Return-Path: <linux-wireless+bounces-20669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC42A6BD02
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 15:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8043B189CD98
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C8A1D515A;
	Fri, 21 Mar 2025 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tc8KoFij"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416531CBEB9
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567611; cv=none; b=p4jCyhc6G64kxJvnyqnRWSt71LbTBe4N/8D9M5pNbCAszw9CUEln6SLBB1dnkZdHyY4a4k+mSGcsn4S/cpeoe3KpsUzZquwMsWp51Jg8epQ1rqOYvlu76n6YUJKN6vHd3vdGLbPDJiXzoKCaAgX7RoBujIORPp1wEFHdB07MOks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567611; c=relaxed/simple;
	bh=Gaqdrhjronf6CLj05Am8Q8pZYTHfCNXp6UVkB4pdUUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IiYv7uz3X4D5slNxaAO7VGFklzucaZl7zkJG6MUblPM3RANsT/8VXOu3qjsDaOoo2gqdMoWak4Q/Bkf25H2Rz59E2fvbNi24j7ugN7cNkmHSCXsdfkJJHP+1FmMNWMlrGLepgUnMHVdxKSmMPAfmHM4QGIcvSZK1sjnC+hUBJy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tc8KoFij; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso19534705e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567608; x=1743172408; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUD2C4napqD5vuJG3mWPuzbrUFJy02UiM24OoqoE4Pw=;
        b=Tc8KoFijQxbeK2YCBLYLNI+LJ6Wv+2fj36uMhGm5QDQZfFO4zPoTNRUDMegcwmzltj
         +zcQFM6RWQTRvTHO6GHuj8qShOAnhgJXPB8FYUgU3TBfabfNFWKZJCgQMxlFvxRzTO0T
         y/HvdiwBsS7lfirbXmLQGL1g2ZCgNjO6+mliJ3enwpikxkqL5YGNyU5cxW/jEXaCtcwP
         EHWFqyFRblxExsyIK6iywZgAMMC6pbXhonylr5vwIth30SBhUSrxYAt4k+A9LUvWbdaR
         HNKBCmcDvna1UWH3wMTVfP5hLFhdYrKr4ePxkriUi6QmNT8k6wIocHKIcwlak6PACLth
         bN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567608; x=1743172408;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUD2C4napqD5vuJG3mWPuzbrUFJy02UiM24OoqoE4Pw=;
        b=HuG/mzmWywH9VVqcB/pMsKT9MREqKBqpBfaFg7GpVywQ2jNKwxGPod6P3n0gNFEVzH
         w9673+gwPVGVuaxbdWwSKYOnmTsgnClaevGwesfjDytMWj2twBaSsPHEcAyrt1Q52RnI
         nMO0pTyu8ah35Ahi8BsN9Yw3Z7nLFgWUU79AWRTmD8vhSbYdZ5P2h8iiLTH95lM4Sqhe
         6ezqbCIk2nfilL0aadvGNQg/Pw+cVuPp+OkSpZQezXh6PqEzzzv7skBcKtU8MCkf28AH
         acT6afDSJ1+wxP+obOqUFYex4uT1vQRP5V9/24Xfa/laENH0D/j/fsSzxJD4AXteCyg9
         ExqA==
X-Gm-Message-State: AOJu0YyiUl5ILzt1a+4TfIvmhhdERO7OKxoU6R3b7LqAQfX0Z+P1SO8y
	79RBaO3B4+Hi+/OsaBctAfyuuekrtTeWRO4xL5JJ0GX0c6WwxIEEg74l12J13UXh6RF/B23kBqo
	h
X-Gm-Gg: ASbGncs5Z2f++8+QW2hJZLAfEbqn+C4jMhOupJp2hMcEZuCy3X0sp8Xbgi/m/tW5mJo
	nMe71X31mmFj1/JH2gAcfQv0lK9Ql1o/jGzg7Z3sqltjU8jcqOrKnGUz67uD4ZaeJT5a/UUnEux
	7W91m6qVzVefJ6KfSfpSzFvlnlwhx+T7tT7twmdE8ZyaZFZmMJRo6Iw/hpFuT10F1CpXYPi/MUq
	B8Jddb2uOT4PGtUIxYnxtXG1F/H2DO5+l/lYCKAsiaWLqusINymzLTaaEIsWx+pQDU2EQ9LAZOq
	Sp8fKJZSyJWXlvFprDtIScU9Tnczs1yc6+wgnIzdA9RwnBIwQA==
X-Google-Smtp-Source: AGHT+IE5scubJ0VsHC95sgPGt3vHpE3oh+MVNiVP1Pc3QU8Ck8WcINMszQ1SBq9HrIYqlen8eCaP3A==
X-Received: by 2002:a05:600c:4e08:b0:43c:fc00:f94f with SMTP id 5b1f17b1804b1-43d50a36d46mr33019815e9.23.1742567608597;
        Fri, 21 Mar 2025 07:33:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fcea400sm28794055e9.2.2025.03.21.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:33:28 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:33:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shayne Chen <shayne.chen@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: Check link_conf pointer in
 mt76_connac_mcu_sta_basic_tlv()
Message-ID: <868e456f-10db-4b0c-bb29-76e3c0d03cc8@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Shayne Chen,

This is a semi-automatic email about new static checker warnings.

Commit 9890624c1b39 ("wifi: mt76: Check link_conf pointer in
mt76_connac_mcu_sta_basic_tlv()") from Mar 11, 2025, leads to the
following Smatch complaint:

    drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c:394 mt76_connac_mcu_sta_basic_tlv()
    warn: variable dereferenced before check 'link_conf' (see line 376)

drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
   375	{
   376		struct ieee80211_vif *vif = link_conf->vif;
                                            ^^^^^^^^^^^^^^
Dereferenced.

   377		struct sta_rec_basic *basic;
   378		struct tlv *tlv;
   379		int conn_type;
   380	
   381		tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_BASIC, sizeof(*basic));
   382	
   383		basic = (struct sta_rec_basic *)tlv;
   384		basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
   385	
   386		if (newly && conn_state != CONN_STATE_DISCONNECT)
   387			basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
   388		basic->conn_state = conn_state;
   389	
   390		if (!link_sta) {
   391			basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
   392	
   393			if (vif->type == NL80211_IFTYPE_STATION &&
   394			    link_conf && !is_zero_ether_addr(link_conf->bssid)) {
                            ^^^^^^^^^
The patch adds a NULL dereference but it's too late.

   395				memcpy(basic->peer_addr, link_conf->bssid, ETH_ALEN);
   396				basic->aid = cpu_to_le16(vif->cfg.aid);

regards,
dan carpenter

