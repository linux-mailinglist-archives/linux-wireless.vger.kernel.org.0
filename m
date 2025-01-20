Return-Path: <linux-wireless+bounces-17737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2888A1699D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 10:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632E71885143
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Jan 2025 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6D1190470;
	Mon, 20 Jan 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rt3cEbja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCD0189B8D
	for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737365425; cv=none; b=LUmP20GOqkP+jYIiWDGouNORD4HqdgMbuiupyfbAX+u+IQ5nEgPkbWaUfG6y9Z9yxGm+0c+WIxfStOnrwQJIgehtS3eYTz6ESM4Kywrd8JmlUMaoB2iqocVPeu0X6TdjdvoMbs/aHC+DlWfBgxiTT7xYI4OKRL1qH72081pnK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737365425; c=relaxed/simple;
	bh=49SI2CJlKOgnaWrfkFh+9jXmTP/5wAJi47FXyahqi7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SuFAxwvTQvrPgD5RNBQ6FApccLJVMKt7XfrIsgGTSnK00zD6n1fEXw23fP67l0LQ4Tc4C7R3pv5LdpuhQ0fEfcvcYUzQbeWfQtWajAfaViNG+e4juk+8VAkf9CNK9KkLwNNPaj3nktZmN5uZv8ymxg+39JMW4k98tIuQbqcQj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Rt3cEbja; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d6d5765so2355601f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Jan 2025 01:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737365422; x=1737970222; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mN2vzQN2MHhC7vsZGZLLyTF4vEgyb2J5Y6QFwZ7uVNs=;
        b=Rt3cEbjaMIk7ST1iP+DQT7xMJcprTogEPGebnIOAOoSRYMB97ZAaxLzwa4Mevh+gPl
         Tt4+eRjVVGxXdprvynRS8kna+nGD8Acs4/l5f6jJWzBsjcfNjOMgOQOly/Y6brdZpkBa
         mEMzyCHIEt4RlsNTgrxYA7/WrVaTXy5mkBx2YnTBh81ouyJHDg6NtCEJfX+CdLcFjnTF
         lLV9K80acX1qlOjsPuLT9y1AXe9iQCSJqVh0d+XZuDSMrpxF0DL61YBeHTL9vONeCySZ
         At3UWvAR5G6NTtAdi/ojQm3FMzi0Cz7u2uu/tdmgWhMEk2GMCof0gj6aKhNAFeqa3Ofc
         f1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737365422; x=1737970222;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mN2vzQN2MHhC7vsZGZLLyTF4vEgyb2J5Y6QFwZ7uVNs=;
        b=V/rzPbaG2JpEGBsd41JhK7rjF8NcYCPes33kU+gijyTpdZKt28oL6j8iGx/T/zRhZu
         sjUyJodwht75wVcW2Sqr1TbcxAu9OSl3gnCXSrjR+eoOc2R/5x+G3cleC6MhUd/G0lR/
         YRJan9h6cl+8kjQ2QDlhm+i7WToXYsMHckETbMKvlpcRwMYIY1uxFg3oZbBEpQNJZw5O
         rO9wVPT6o3g36JYPZ2uWGROrIkeZUB3YPXF5IlT+JpN/b7cw/oN0awlV8m7ADsvqeQYX
         FCOOlK+gsp53t/QK9pICs4nqhSUa5daNNUCtWjspgxewMwnplSs7NcOFxwzm1QpFVf4v
         m5oA==
X-Gm-Message-State: AOJu0YzVEUDrR68pEjjzbguAGzzbShkLbYanOPlNMBA6kgKOzRSVP/C/
	GZ2NshbWoQ/Nb32lRR9IINBH3Twzdtx/VzzZ8RRAv4xyvVSKRoUxv/UKRUhEzZQ3Ojmt6Ox2Zem
	s
X-Gm-Gg: ASbGncs86t9nRIFkazaVH3K5pI6jB3LtDhW6rBhITSH5+fSBUrG1uGdVDc8Q7fU/S8S
	nz+QPULy9GShZrpaK44FzFAZgXUwLI30FxdXBrwBBkQxr3n4HbnDq/Q7SYYd3+VktDPq71exAay
	8/lmBywed/e7Ul+SDoIwHoNWo00UwtBeQUNc7x3BTo5TdhqhQznb1oaDmISGZ782mvLYiU4cpzh
	nNDwzGaUyBZW4DYUiJIYj3PpTy9J2BNEsQnU397OTp9BbsXAgkACSqXizANSJ/GAu4OlhgBwWo=
X-Google-Smtp-Source: AGHT+IEZXASFrmYShzNvlF7HMBo84fpqQweouX7QZO3kXwCjuF6druhkZHwPyP/GtHrteNSIXdX06w==
X-Received: by 2002:a05:6000:1f85:b0:38b:e32a:109d with SMTP id ffacd0b85a97d-38bf59e1d83mr9745687f8f.34.1737365421747;
        Mon, 20 Jan 2025 01:30:21 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890468869sm130364155e9.35.2025.01.20.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 01:30:21 -0800 (PST)
Date: Mon, 20 Jan 2025 12:30:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Charles Han <hanchunchao@inspur.com>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [bug report] wifi: mt76: mt7925: fix NULL deref check in
 mt7925_change_vif_links
Message-ID: <7f806676-a698-4081-81b7-4a48435d2f82@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Charles Han,

Commit 5cd0bd815c8a ("wifi: mt76: mt7925: fix NULL deref check in
mt7925_change_vif_links") from Oct 25, 2024 (linux-next), leads to
the following Smatch static checker warning:

	drivers/net/wireless/mediatek/mt76/mt7925/main.c:2053 mt7925_change_vif_links()
	warn: inconsistent returns '&dev->mt76.mutex'.

drivers/net/wireless/mediatek/mt76/mt7925/main.c
    1947 static int
    1948 mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
    1949                         u16 old_links, u16 new_links,
    1950                         struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
    1951 {
    1952         struct mt792x_bss_conf *mconfs[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mconf;
    1953         struct mt792x_link_sta *mlinks[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mlink;
    1954         struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
    1955         unsigned long add = new_links & ~old_links;
    1956         unsigned long rem = old_links & ~new_links;
    1957         struct mt792x_dev *dev = mt792x_hw_dev(hw);
    1958         struct mt792x_phy *phy = mt792x_hw_phy(hw);
    1959         struct ieee80211_bss_conf *link_conf;
    1960         unsigned int link_id;
    1961         int err;
    1962 
    1963         if (old_links == new_links)
    1964                 return 0;
    1965 
    1966         mt792x_mutex_acquire(dev);
    1967 
    1968         for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
    1969                 mconf = mt792x_vif_to_link(mvif, link_id);
    1970                 mlink = mt792x_sta_to_link(&mvif->sta, link_id);
    1971 
    1972                 if (!mconf || !mlink)
    1973                         continue;
    1974 
    1975                 if (mconf != &mvif->bss_conf) {
    1976                         mt792x_mac_link_bss_remove(dev, mconf, mlink);
    1977                         devm_kfree(dev->mt76.dev, mconf);
    1978                         devm_kfree(dev->mt76.dev, mlink);
    1979                 }
    1980 
    1981                 rcu_assign_pointer(mvif->link_conf[link_id], NULL);
    1982                 rcu_assign_pointer(mvif->sta.link[link_id], NULL);
    1983         }
    1984 
    1985         for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
    1986                 if (!old_links) {
    1987                         mvif->deflink_id = link_id;
    1988                         mconf = &mvif->bss_conf;
    1989                         mlink = &mvif->sta.deflink;
    1990                 } else {
    1991                         mconf = devm_kzalloc(dev->mt76.dev, sizeof(*mconf),
    1992                                              GFP_KERNEL);
    1993                         mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
    1994                                              GFP_KERNEL);
    1995                         if (!mconf || !mlink)
    1996                                 return -ENOMEM;

Need to call mt792x_mutex_release(dev) before returning.

    1997                 }
    1998 
    1999                 mconfs[link_id] = mconf;
    2000                 mlinks[link_id] = mlink;
    2001                 mconf->link_id = link_id;
    2002                 mconf->vif = mvif;
    2003                 mlink->wcid.link_id = link_id;
    2004                 mlink->wcid.link_valid = !!vif->valid_links;
    2005                 mlink->wcid.def_wcid = &mvif->sta.deflink.wcid;
    2006         }
    2007 
    2008         if (hweight16(mvif->valid_links) == 0)
    2009                 mt792x_mac_link_bss_remove(dev, &mvif->bss_conf,
    2010                                            &mvif->sta.deflink);
    2011 
    2012         for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
    2013                 mconf = mconfs[link_id];
    2014                 mlink = mlinks[link_id];
    2015                 link_conf = mt792x_vif_to_bss_conf(vif, link_id);
    2016 
    2017                 rcu_assign_pointer(mvif->link_conf[link_id], mconf);
    2018                 rcu_assign_pointer(mvif->sta.link[link_id], mlink);
    2019 
    2020                 err = mt7925_mac_link_bss_add(dev, link_conf, mlink);
    2021                 if (err < 0)
    2022                         goto free;
    2023 
    2024                 if (mconf != &mvif->bss_conf) {
    2025                         mt7925_mcu_set_bss_pm(dev, link_conf, true);
    2026 
    2027                         err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
    2028                                                  vif->active_links);
    2029                         if (err < 0)
    2030                                 goto free;
    2031                 }
    2032         }
    2033 
    2034         mvif->valid_links = new_links;
    2035 
    2036         mt792x_mutex_release(dev);
    2037 
    2038         return 0;
    2039 
    2040 free:
    2041         for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
    2042                 rcu_assign_pointer(mvif->link_conf[link_id], NULL);
    2043                 rcu_assign_pointer(mvif->sta.link[link_id], NULL);
    2044 
    2045                 if (mconf != &mvif->bss_conf)
    2046                         devm_kfree(dev->mt76.dev, mconfs[link_id]);
    2047                 if (mlink != &mvif->sta.deflink)
    2048                         devm_kfree(dev->mt76.dev, mlinks[link_id]);
    2049         }
    2050 
    2051         mt792x_mutex_release(dev);
    2052 
--> 2053         return err;
    2054 }

regards,
dan carpenter

