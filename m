Return-Path: <linux-wireless+bounces-24488-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDFBAE87F2
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 17:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29F4D175808
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A050528D8FB;
	Wed, 25 Jun 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRDpV8x+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B3910942
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750864961; cv=none; b=LtC/i6QIU7UuqmJUf+U4dxh9QQ+Xb3LAaV3ZpBRAPGk8L+SxM5l1eGYfT6+bh0YVzazapQ+SGob/97xpttu1wY/IqdkGf7ZCrVSJZFFZu10Ea7EGuquKFAyWLkx8ukipX1136T2xETMRZY0zu9+bC018DtFr+oyjmDY9Daokdqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750864961; c=relaxed/simple;
	bh=ahDkylJlWV6yIJvOk87q3Hhzt7yMMnBLATOf3igMxbc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=N2vTe6j9htkMzz1IE02hXdf7v8clGbWWQFlUDAQQhM4oNKxfTbZ+QC7k8SsoNeZdPQFPJo9uvWiY6KN90dKq3TZYAFFLNVH8ixaaAkDiw68Mejh/Rw/4aFZRzhFI0FPnahx5YFZG/KLfd6wfsaRnqE8p6Tl7uUX09kKsGOLZCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRDpV8x+; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-60be827f2b7so645572eaf.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750864958; x=1751469758; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEFHtV5vxf5zb+tIs/qh5kRcSwNQ0cdHi0Ku63sa+ss=;
        b=KRDpV8x+jH/97BoNoAaFxHcNlJ7d4p6XIbgjvZkNOd2fLGFfOYow5X1fP0mqZ0wQOf
         qdIemCjoQYe68HXSByLO+O6UKoEYdZQKqSH9yjazqb9WL2OUTWjOnD1DNJ822QO6iUpW
         YkhvoCaH6pPEjLjhU9ejrh5GTEcD/PgEqBzaMh7STwJ+VrPNoIPAhPCJTBCUdYezs5sb
         850yIJ3u7QmJltAifDuIBZsDg+/4G7QuRKoQgMDex9oDNK/YU8A4AfEQrZLvqzG0ciCX
         3g1T6XHyL9YTtdkifxBuKtOB4HxiKwVJTaQuYK1uJhAkGh6vziyhwrUhVnFLzNZbDBOZ
         v/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750864958; x=1751469758;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEFHtV5vxf5zb+tIs/qh5kRcSwNQ0cdHi0Ku63sa+ss=;
        b=Do51OLwfZ5okYTF1jbnpxOrK77H+KGN+GKsnmTVcj9YxpYqZa9XEfWK69ncBKI/YyA
         1k0PJXiO1VHhiEJhMgFEKZZ970uRTHoQcLBWDaDnazTNGH7xTS26zjKH9J9eczomoccf
         g3WLztQMmXYCbx27YG0yUmtaCsM5u4TaURB9NNhRLPMKaq5u8aVlK5DHDch7PY34sKmf
         MNEF/wNRmU04xxykiooA++4TVu0HsQpNAe0RzKupPwLAATlhja/V+x/dQSyNYiWKtywQ
         D6EFL2mxTAGrW0HOvFGLBtMPDpUNsBzk8gL3O/wpdpmNuVa8bOI/HDJ3EcPzygAsuCGa
         vrbQ==
X-Gm-Message-State: AOJu0YxwxeEdis80OpFqJbUl5MC3MfYd8KmGS7KIcdouoS9tfICMNxfl
	SOZvS16nqaHqjeCrruj4gWlPH2t9LYcIesUS565YqXktgLvAqa00IRfyi8uNwuqWeGCP52lAfib
	V7vRs
X-Gm-Gg: ASbGncvCcD0WXlIwiqJwbv0EcL/u7SWvgTZZAXvRAYwDp69cVr7y0gjDPqKruYPasMu
	oLRaPHJh/GBUKVAx+WHjTnW2s3i4vURpwO1oexWwmJLOs467BgweRpg/nVcssK6mad/3zNMh2YV
	jX3PjD58eYLh5jDWjL2fzd7NM5X2xPWAUQaRaoGSViMqeWH9lkrdYi1B6gPo7D/gChAaHpLjgnK
	g1forizutaK62IOwqzAgpWDQP/tbJQE4eznwYIhCCuPInOtCLFSmLx4sSiaPFkJK/LDGYr2CIta
	bFI4+EQSzPOgYuovWtjuLYvOCouHzraD6WNJIMUtWT9Uijx1uga73WRc0i6W86vjmVXnlQ==
X-Google-Smtp-Source: AGHT+IFHxRRAQoCy4i1T3IHOUzPocziGtUS8Dk+opafUpg2P980j4psy7fAAHvkrBAt4ZGQ5QnJO5A==
X-Received: by 2002:a05:6871:a711:b0:2da:b91c:919b with SMTP id 586e51a60fabf-2efcea6e865mr7674fac.0.1750864957872;
        Wed, 25 Jun 2025 08:22:37 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:1fca:a60b:12ab:43a3])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6115b6cec03sm1628521eaf.13.2025.06.25.08.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 08:22:37 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:22:36 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [bug report] wifi: iwlwifi: add iwlmld sub-driver
Message-ID: <5e346776-6854-46fc-aa41-a1ac3b395d70@sabinyo.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Miri Korenblit,

The patch d1e879ec600f: "wifi: iwlwifi: add iwlmld sub-driver" from
Feb 16, 2025, leads to the following static checker warning:

	drivers/net/wireless/intel/iwlwifi/mld/d3.c:1232 iwl_mld_wait_d3_notif()
	error: uninitialized symbol 'd3_status'.

drivers/net/wireless/intel/iwlwifi/mld/d3.c
    1200 static int iwl_mld_wait_d3_notif(struct iwl_mld *mld,
    1201 				 struct iwl_mld_resume_data *resume_data,
    1202 				 bool with_wowlan)
    1203 {
    1204 	static const u16 wowlan_resume_notif[] = {
    1205 		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_INFO_NOTIFICATION),
    1206 		WIDE_ID(PROT_OFFLOAD_GROUP, WOWLAN_WAKE_PKT_NOTIFICATION),
    1207 		WIDE_ID(SCAN_GROUP, OFFLOAD_MATCH_INFO_NOTIF),
    1208 		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
    1209 	};
    1210 	static const u16 d3_resume_notif[] = {
    1211 		WIDE_ID(PROT_OFFLOAD_GROUP, D3_END_NOTIFICATION)
    1212 	};
    1213 	struct iwl_notification_wait wait_d3_notif;
    1214 	enum iwl_d3_status d3_status;
    1215 	int ret;
    1216 
    1217 	if (with_wowlan)
    1218 		iwl_init_notification_wait(&mld->notif_wait, &wait_d3_notif,
    1219 					   wowlan_resume_notif,
    1220 					   ARRAY_SIZE(wowlan_resume_notif),
    1221 					   iwl_mld_handle_d3_notif,
    1222 					   resume_data);
    1223 	else
    1224 		iwl_init_notification_wait(&mld->notif_wait, &wait_d3_notif,
    1225 					   d3_resume_notif,
    1226 					   ARRAY_SIZE(d3_resume_notif),
    1227 					   iwl_mld_handle_d3_notif,
    1228 					   resume_data);
    1229 
    1230 	ret = iwl_trans_d3_resume(mld->trans, &d3_status, false, false);
    1231 	if (ret || d3_status != IWL_D3_STATUS_ALIVE) {
--> 1232 		if (d3_status != IWL_D3_STATUS_ALIVE) {

This should be an if (!ret) test.  On this path d3_status could be
uninitialized.

    1233 			IWL_INFO(mld, "Device was reset during suspend\n");
    1234 			ret = -ENOENT;
    1235 		} else {
    1236 			IWL_ERR(mld, "Transport resume failed\n");
    1237 		}
    1238 		iwl_remove_notification(&mld->notif_wait, &wait_d3_notif);
    1239 		return ret;
    1240 	}
    1241 
    1242 	ret = iwl_wait_notification(&mld->notif_wait, &wait_d3_notif,
    1243 				    IWL_MLD_D3_NOTIF_TIMEOUT);
    1244 	if (ret)
    1245 		IWL_ERR(mld, "Couldn't get the d3 notif %d\n", ret);
    1246 
    1247 	if (resume_data->notif_handling_err)
    1248 		ret = -EIO;
    1249 
    1250 	return ret;
    1251 }

regards,
dan carpenter

