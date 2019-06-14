Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD6F46033
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfFNOLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:11:19 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42672 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfFNOLS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:11:18 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbmvE-00024K-BJ; Fri, 14 Jun 2019 16:11:16 +0200
Message-ID: <8d0d11ca39b6216b24cf4e9e3a1522072db5c0d2.camel@sipsolutions.net>
Subject: Re: [PATCH v3 2/3] mac80211: implement HE support for mesh
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sven Eckelmann <sven@narfation.org>, linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org, Sven Eckelmann <seckelmann@datto.com>
Date:   Fri, 14 Jun 2019 16:11:15 +0200
In-Reply-To: <20190612193510.29489-3-sven@narfation.org> (sfid-20190612_213644_171180_98373DED)
References: <20190612193510.29489-1-sven@narfation.org>
         <20190612193510.29489-3-sven@narfation.org>
         (sfid-20190612_213644_171180_98373DED)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-06-12 at 21:35 +0200, Sven Eckelmann wrote:
> 
> +u8 ieee80211_ie_len_he_cap(struct ieee80211_sub_if_data *sdata)
> +{
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	struct ieee80211_supported_band *sband;
> +	u8 ie_len;
> +	u8 n;
> +
> +	sband = ieee80211_get_sband(sdata);
> +	if (!sband)
> +		return 0;
> +
> +	he_cap = ieee80211_get_he_mesh_cap(sband);
> +	if (!he_cap)
> +		return 0;
> +
> +	n = ieee80211_he_mcs_nss_size(&he_cap->he_cap_elem);
> +	ie_len = 2 + 1 +
> +		 sizeof(he_cap->he_cap_elem) + n +
> +		 ieee80211_he_ppe_size(he_cap->ppe_thres[0],
> +				       he_cap->he_cap_elem.phy_cap_info);
> +
> +	return ie_len;

There's no value in the "ie_len" variable here.

johannes

