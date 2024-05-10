Return-Path: <linux-wireless+bounces-7480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59AF8C274A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 17:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EA01C215C2
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC7A17106E;
	Fri, 10 May 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nP+gHqxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98112C53F
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353542; cv=none; b=MRZotyFMmWyHEzXGVHO32RuyPqxTBJwue8ko2gGSjk3wcGckdx2cQkXg32itcZVCFtshf9P0RKd0BPMLpnYviXC5gNuiQlVgqSj/zlwVzkL8Q2i6EXKxCw+2tbmvFykb6Kov9a7YCVpIS/0cHxoxy0zbkfddmalP3EoB90f9CH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353542; c=relaxed/simple;
	bh=QJaALQV7MbXQwjR8hRV79wji1xck01AMI7+bfXTKIqc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lFcsmJckLA2+aga00V9ybw1OOT2xtdhdFfLrWmM1jnwbc5J3g/jqqY5wHBFJH3H2Kip00MZIE5kxokB6sF9IbWpsPC9pq4l4/fK/Tr4fp+GH6khjoM2pglS2dO7K7a1iLOAXgIpz2UxZ0uJsDuOOJS7ccxiJiqdzbvl5fgttnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nP+gHqxR; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59a64db066so561296066b.3
        for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 08:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715353539; x=1715958339; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pNpTMmChh82NLuGK3ZH9f0+BWskXnK3a62sBkKDp8+0=;
        b=nP+gHqxRSfXzrpAq145WERbBCD3/n890kSHcVSSi7zYi7QLcUuCENRa+YBuJvkqng2
         AAP/PJ7PPaKWS9c8szFFnFdEIBgmczE++ACvhCJpBB6HDPAE6Ys5UlldiodUXOk+oNwS
         kICe7CgTAdeHGfeRqvXEN3eIuGurO5fGUD1ZX9fTMZM7+PsbbdTeuxYctzsU/dvQDRZq
         UUoS05pnjXC6aE5LpLJgQUOE4k8R57sST3o8hUsxv0gkBOLsKLsEFXx6VKLdWNOQrvcn
         45lLJshmAqTajpCXuOWX7DtMtJcE3wz17upogXoX7x5BNZXy51Z9xXnr1IB/FgNHzM6B
         p7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353539; x=1715958339;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNpTMmChh82NLuGK3ZH9f0+BWskXnK3a62sBkKDp8+0=;
        b=bS0XQGFIi73Oq1JQeoYydDuifLc653ppc07k3MRWIa4LnaZluTH2mX12EpnW6i67Hm
         z/vkw/PHFMblMXOd6yIfjPaKU/zoPWGZQYVykKM/Yj/9swnBzbifcMsqJWuk+Arm+GuS
         oubWfXxKO5JxfD6KIe4tsYUKBkl3nojMHZgtS3bu1RcI9TDgTzgqDX1kEklYa5CY0dlO
         nXupwW8lqTUg68Zqy2Aokc3InP89NSpszYjbq4uqR62mOJf5bsySTUxLMjVjhw0rIwum
         bl/hRYsAKbDQI1N48ki7otSQ94mbuG0EsoLonHFiT9SBore0FLQZk7xrtHUVtWY1jipk
         bNdA==
X-Gm-Message-State: AOJu0YxX1sITYZa3BIOZbK6xwdczFMWgjv6XNFJfHvkdZxMN191b3+Tz
	sRlDtP/IUQaK9svI0g/8fgqU4qpW4A611OukUqVu8nUcGyM/NZ7yB5U0/2cHwmBvkQnvjNg5YHn
	J
X-Google-Smtp-Source: AGHT+IHa7OZocXWGwXgZYGwxqhRHhseAD29kYbZx9ShqNVaWYVnLzVemZA3M5bPWX1BmfNwBncN7ZQ==
X-Received: by 2002:a17:906:69d7:b0:a59:c681:6314 with SMTP id a640c23a62f3a-a5a2d5cd7admr178179466b.42.1715353538936;
        Fri, 10 May 2024 08:05:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1789247csm189892666b.82.2024.05.10.08.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:05:38 -0700 (PDT)
Date: Fri, 10 May 2024 18:05:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: yedidya.ben.shimol@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: mvm: Block EMLSR when a p2p/softAP vif
 is active
Message-ID: <c115d43e-9087-407b-832a-9e6925b882ac@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Yedidya Benshimol,

Commit a1efeb823084 ("wifi: iwlwifi: mvm: Block EMLSR when a
p2p/softAP vif is active") from May 5, 2024 (linux-next), leads to
the following Smatch static checker warning:

	drivers/net/wireless/intel/iwlwifi/mvm/time-event.c:1277 iwl_mvm_stop_roc()
	warn: inconsistent returns '&mvm->mutex'.

drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
    1225 void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
    1226 {
    1227         struct iwl_mvm_vif *mvmvif;
    1228         struct iwl_mvm_time_event_data *te_data;
    1229 
    1230         mutex_lock(&mvm->mutex);
    1231 
    1232         if (fw_has_capa(&mvm->fw->ucode_capa,
    1233                         IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
    1234                 mvmvif = iwl_mvm_vif_from_mac80211(vif);
    1235                 te_data = &mvmvif->time_event_data;
    1236 
    1237                 if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
    1238                         if (te_data->id >= SESSION_PROTECT_CONF_MAX_ID) {
    1239                                 IWL_DEBUG_TE(mvm,
    1240                                              "No remain on channel event\n");
    1241                                 return;

Call mutex_unlock(&mvm->mutex) or iwl_mvm_cleanup_roc() before returning?

    1242                         }
    1243 
    1244                         iwl_mvm_cancel_session_protection(mvm, vif,
    1245                                                           te_data->id,
    1246                                                           te_data->link_id);
    1247                 } else {
    1248                         iwl_mvm_roc_station_remove(mvm, mvmvif);
    1249                 }
    1250                 goto cleanup_roc;
    1251         }
    1252 
    1253         te_data = iwl_mvm_get_roc_te(mvm);
    1254         if (!te_data) {
    1255                 IWL_WARN(mvm, "No remain on channel event\n");
    1256                 return;

Here too.

    1257         }
    1258 
    1259         mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
    1260 
    1261         if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE)
    1262                 iwl_mvm_remove_time_event(mvm, mvmvif, te_data);
    1263         else
    1264                 iwl_mvm_remove_aux_roc_te(mvm, mvmvif, te_data);
    1265 
    1266 cleanup_roc:
    1267         /*
    1268          * In case we get here before the ROC event started,
    1269          * (so the status bit isn't set) set it here so iwl_mvm_cleanup_roc will
    1270          * cleanup things properly
    1271          */
    1272         set_bit(vif->type == NL80211_IFTYPE_P2P_DEVICE ?
    1273                 IWL_MVM_STATUS_ROC_RUNNING : IWL_MVM_STATUS_ROC_AUX_RUNNING,
    1274                 &mvm->status);
    1275 
    1276         /* Mutex is released inside this function */
--> 1277         iwl_mvm_cleanup_roc(mvm);
    1278 }

regards,
dan carpenter

