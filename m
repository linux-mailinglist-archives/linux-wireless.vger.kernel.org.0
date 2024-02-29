Return-Path: <linux-wireless+bounces-4249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617AE86C79D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 12:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B2A1C2298D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 11:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A562808;
	Thu, 29 Feb 2024 11:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CKk3PspR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2179DA6
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204440; cv=none; b=cIY7i2Hp1KUMbdBLSuoXT6w2iCMGL240B9m+JnK91Wu7OW1U/SIlzKHZXD2qRtydM/PiNcHqXzHONu290NH+X+8Y0mRDIH0vG3ys9C/7G5RT+BphbmteZt1fkIJXBwx3t11S58SVuFUhPV8PecxnRuhQnCZFGqNZQgnwmMGJaXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204440; c=relaxed/simple;
	bh=ifvVAru1y42jBWSO0OfQwWpw5aF/oYOpKzB6+XJIIZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cF8RCK0BEjM2ETxXBhWChpzjMFUAxvQ014cMIXLLYCV5cIVVlJ72egmzgC0tBzb2QMpjL7NyxRfA49uJS2iKQDQ3lt0hxrdIMVdRlm1yjSWYoZ4W55L9Mg5+cb1L3wwu774hmQXkbmB1QFDy3xEbydKh4Srf7LhX7ND4hq0AZTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CKk3PspR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d288bac3caso6652771fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709204437; x=1709809237; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mv2n8EMeh9kY7H1GsuYFHzgqi4aIWz/r4yYpmLe22+M=;
        b=CKk3PspRMKU1zuiv5K5e1is1WXeetr45yOBuxOYYB0QZ4NUz5PhwD6kiZDhhVYHBTW
         RTFKM9JbQmmzcXwSHxi4O+pDnFbSIU/vzVE5i77quRlBtFUT+2fglI3VXJw9mfZSDU57
         LzFdtKZRoMEc60MLx9fhIRd0aiZLpVaNVIVYhwaUUc2D8nrvY5Y7zPqX/Wc9DV9as5yR
         jP3LxdiorprM5phzoneH+8MdPKmhuv7IH6Co+uP++9FdGQGrxx5aihEwf1PoNh5hYwYe
         iec0Uh2c/zdydSX++/d1lcTXkdIixSMnScKX9Tr65NdEbqZQtvxruTN4GKlVNY8nhOKl
         12Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709204437; x=1709809237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mv2n8EMeh9kY7H1GsuYFHzgqi4aIWz/r4yYpmLe22+M=;
        b=mMmH0rZ0i/JAuViKpcroML2IpuaftNc57eswF0gd7KNALiXHmxLi26/IZ948SRVI9z
         i9pfKSeeW8nAnwErg2t1j39F4/IohjXpOovcH5cYOIdyZS/tZoNAwCrsHm5RsEe/rFbg
         Kc5qxK4SKZesQIcxRXTVHzQuAV7lOsrBOXweAGT1DFLIt9v5pYNJDKyyQ0+RXUQwCd8b
         +lZnUDIniLHIiGArmknTu+J9P+9ZqV5gY72JWQqFhI3+h0d6X5RiwzqsQLMa8E7IR9ci
         5X1fpgbqIkAnEnejaJ3o3WGQbSnG+2xQdS7Zd4DaRB5p8Cal4sHbdO9m8/pxnCjJg5lc
         6BlQ==
X-Gm-Message-State: AOJu0YzMPaXVfmSTr07TTlKLExT3aqfTnbNGvvEu94Nisv3Ol1+uRgqa
	WkzF0fKjCRJOV+eL3730Eak7UHU08xp1v/PDLhJlu/VOcvRAxKbt1FKM99aywME2Gn5UU5AzMOd
	L
X-Google-Smtp-Source: AGHT+IERbv9T6EGxiO8S+DvqSZU+rtgSkENYR3rx0rvWo2bKFCgrgFxdj2OFb+D8xvl3+2BtKnFyig==
X-Received: by 2002:a19:5217:0:b0:512:d91f:2e57 with SMTP id m23-20020a195217000000b00512d91f2e57mr1208249lfb.55.1709204436959;
        Thu, 29 Feb 2024 03:00:36 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id u9-20020a056000038900b0033dca6f8b44sm1492028wrf.16.2024.02.29.03.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 03:00:36 -0800 (PST)
Date: Thu, 29 Feb 2024 14:00:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: johannes.berg@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: mac80211: clean up connection process
Message-ID: <3151f5d0-c18f-413d-b34b-b94f095b947c@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Johannes Berg,

The patch 310c8387c638: "wifi: mac80211: clean up connection process"
from Jan 29, 2024 (linux-next), leads to the following Smatch static
checker warning:

net/mac80211/mlme.c:8176 ieee80211_mgd_assoc() error: uninitialized symbol 'match_auth'.
net/mac80211/mlme.c:8177 ieee80211_mgd_assoc() error: we previously assumed 'link' could be null (see line 8169)
net/mac80211/mlme.c:8220 ieee80211_mgd_assoc() error: uninitialized symbol 'match_auth'.

net/mac80211/mlme.c
    8051 int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
    8052                         struct cfg80211_assoc_request *req)
    8053 {
    8054         unsigned int assoc_link_id = req->link_id < 0 ? 0 : req->link_id;
    8055         struct ieee80211_local *local = sdata->local;
    8056         struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
    8057         struct ieee80211_mgd_assoc_data *assoc_data;
    8058         const struct element *ssid_elem;
    8059         struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
    8060         struct ieee80211_link_data *link;
    8061         struct cfg80211_bss *cbss;
    8062         bool override, uapsd_supported;
    8063         bool match_auth;

match_auth should probably be set to false...

    8064         int i, err;
    8065         size_t size = sizeof(*assoc_data) + req->ie_len;
    8066 
    8067         for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++)
    8068                 size += req->links[i].elems_len;
    8069 
    8070         /* FIXME: no support for 4-addr MLO yet */
    8071         if (sdata->u.mgd.use_4addr && req->link_id >= 0)
    8072                 return -EOPNOTSUPP;
    8073 
    8074         assoc_data = kzalloc(size, GFP_KERNEL);
    8075         if (!assoc_data)
    8076                 return -ENOMEM;
    8077 
    8078         cbss = req->link_id < 0 ? req->bss : req->links[req->link_id].bss;
    8079 
    8080         if (ieee80211_mgd_csa_in_process(sdata, cbss)) {
    8081                 sdata_info(sdata, "AP is in CSA process, reject assoc\n");
    8082                 err = -EINVAL;
    8083                 goto err_free;
    8084         }
    8085 
    8086         rcu_read_lock();
    8087         ssid_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_SSID);
    8088         if (!ssid_elem || ssid_elem->datalen > sizeof(assoc_data->ssid)) {
    8089                 rcu_read_unlock();
    8090                 err = -EINVAL;
    8091                 goto err_free;
    8092         }
    8093 
    8094         memcpy(assoc_data->ssid, ssid_elem->data, ssid_elem->datalen);
    8095         assoc_data->ssid_len = ssid_elem->datalen;
    8096         rcu_read_unlock();
    8097 
    8098         if (req->ap_mld_addr)
    8099                 memcpy(assoc_data->ap_addr, req->ap_mld_addr, ETH_ALEN);
    8100         else
    8101                 memcpy(assoc_data->ap_addr, cbss->bssid, ETH_ALEN);
    8102 
    8103         if (ifmgd->associated) {
    8104                 u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
    8105 
    8106                 sdata_info(sdata,
    8107                            "disconnect from AP %pM for new assoc to %pM\n",
    8108                            sdata->vif.cfg.ap_addr, assoc_data->ap_addr);
    8109                 ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
    8110                                        WLAN_REASON_UNSPECIFIED,
    8111                                        false, frame_buf);
    8112 
    8113                 ieee80211_report_disconnect(sdata, frame_buf,
    8114                                             sizeof(frame_buf), true,
    8115                                             WLAN_REASON_UNSPECIFIED,
    8116                                             false);
    8117         }
    8118 
    8119         memcpy(&ifmgd->ht_capa, &req->ht_capa, sizeof(ifmgd->ht_capa));
    8120         memcpy(&ifmgd->ht_capa_mask, &req->ht_capa_mask,
    8121                sizeof(ifmgd->ht_capa_mask));
    8122 
    8123         memcpy(&ifmgd->vht_capa, &req->vht_capa, sizeof(ifmgd->vht_capa));
    8124         memcpy(&ifmgd->vht_capa_mask, &req->vht_capa_mask,
    8125                sizeof(ifmgd->vht_capa_mask));
    8126 
    8127         memcpy(&ifmgd->s1g_capa, &req->s1g_capa, sizeof(ifmgd->s1g_capa));
    8128         memcpy(&ifmgd->s1g_capa_mask, &req->s1g_capa_mask,
    8129                sizeof(ifmgd->s1g_capa_mask));
    8130 
    8131         /* keep some setup (AP STA, channel, ...) if matching */
    8132         if (ifmgd->auth_data)
    8133                 match_auth = ether_addr_equal(ifmgd->auth_data->ap_addr,
    8134                                               assoc_data->ap_addr) &&
    8135                              ifmgd->auth_data->link_id == req->link_id;

match_auth isn't initialized on the else path.

    8136 
    8137         if (req->ap_mld_addr) {
    8138                 uapsd_supported = true;
    8139 
    8140                 for (i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
    8141                         struct ieee80211_supported_band *sband;
    8142                         struct cfg80211_bss *link_cbss = req->links[i].bss;
    8143                         struct ieee80211_bss *bss;
    8144 
    8145                         if (!link_cbss)
    8146                                 continue;
    8147 
    8148                         bss = (void *)link_cbss->priv;
    8149 
    8150                         if (!bss->wmm_used) {
    8151                                 err = -EINVAL;
    8152                                 goto err_free;
    8153                         }
    8154 
    8155                         if (req->flags & (ASSOC_REQ_DISABLE_HT |
    8156                                           ASSOC_REQ_DISABLE_VHT |
    8157                                           ASSOC_REQ_DISABLE_HE |
    8158                                           ASSOC_REQ_DISABLE_EHT)) {
    8159                                 err = -EINVAL;
    8160                                 goto err_free;
    8161                         }
    8162 
    8163                         if (link_cbss->channel->band == NL80211_BAND_S1GHZ) {
    8164                                 err = -EINVAL;
    8165                                 goto err_free;
    8166                         }
    8167 
    8168                         link = sdata_dereference(sdata->link[i], sdata);
    8169                         if (link)
                                     ^^^^
link checked for NULL

    8170                                 ether_addr_copy(assoc_data->link[i].addr,
    8171                                                 link->conf->addr);
    8172                         else
    8173                                 eth_random_addr(assoc_data->link[i].addr);
    8174                         sband = local->hw.wiphy->bands[link_cbss->channel->band];
    8175 
--> 8176                         if (match_auth && i == assoc_link_id)
                                     ^^^^^^^^^^
Potentially uninitialized

    8177                                 assoc_data->link[i].conn = link->u.mgd.conn;
                                                                    ^^^^^^
Unchecked dereference.  This one is probably a false positive, but I
just thought I would report it for completeness.

    8178                         else
    8179                                 assoc_data->link[i].conn =
    8180                                         ieee80211_conn_settings_unlimited;
    8181                         ieee80211_determine_our_sta_mode_assoc(sdata, sband,
    8182                                                                req, true, i,
    8183                                                                &assoc_data->link[i].conn);
    8184                         assoc_data->link[i].bss = link_cbss;
    8185                         assoc_data->link[i].disabled = req->links[i].disabled;
    8186 
    8187                         if (!bss->uapsd_supported)
    8188                                 uapsd_supported = false;
    8189 
    8190                         if (assoc_data->link[i].conn.mode < IEEE80211_CONN_MODE_EHT) {
    8191                                 err = -EINVAL;
    8192                                 req->links[i].error = err;
    8193                                 goto err_free;
    8194                         }
    8195                 }
    8196 
    8197                 assoc_data->wmm = true;
    8198         } else {
    8199                 struct ieee80211_supported_band *sband;
    8200                 struct ieee80211_bss *bss = (void *)cbss->priv;
    8201 
    8202                 memcpy(assoc_data->link[0].addr, sdata->vif.addr, ETH_ALEN);
    8203                 assoc_data->s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
    8204 
    8205                 assoc_data->wmm = bss->wmm_used &&
    8206                                   (local->hw.queues >= IEEE80211_NUM_ACS);
    8207 
    8208                 if (cbss->channel->band == NL80211_BAND_6GHZ &&
    8209                     req->flags & (ASSOC_REQ_DISABLE_HT |
    8210                                   ASSOC_REQ_DISABLE_VHT |
    8211                                   ASSOC_REQ_DISABLE_HE)) {
    8212                         err = -EINVAL;
    8213                         goto err_free;
    8214                 }
    8215 
    8216                 sband = local->hw.wiphy->bands[cbss->channel->band];
    8217 
    8218                 assoc_data->link[0].bss = cbss;
    8219 
    8220                 if (match_auth)
                             ^^^^^^^^^^
Here is the other match_auth warning.


    8221                         assoc_data->link[0].conn = sdata->deflink.u.mgd.conn;
    8222                 else
    8223                         assoc_data->link[0].conn =
    8224                                 ieee80211_conn_settings_unlimited;
    8225                 ieee80211_determine_our_sta_mode_assoc(sdata, sband, req,
    8226                                                        assoc_data->wmm, 0,
    8227                                                        &assoc_data->link[0].conn);
    8228 
    8229                 uapsd_supported = bss->uapsd_supported;
    8230         }

regards,
dan carpenter

