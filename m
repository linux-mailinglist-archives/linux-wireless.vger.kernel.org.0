Return-Path: <linux-wireless+bounces-35266-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE6lNU0x62lfJwAAu9opvQ
	(envelope-from <linux-wireless+bounces-35266-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 11:01:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C72545BD14
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 11:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AECF302E921
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2026 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C9835C193;
	Fri, 24 Apr 2026 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRCG84/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58234219A8A
	for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777021178; cv=none; b=h62EjNSTIEhjNEHTr3ULQr5giiYX7IYjzrTlHbFR43um/h7xFjtFiv0IvnSQoLctCySUC3rvuSaSCJJimX2g3mWvTfRMti9ix4c0vgyaxEHDpxwQL0eSzZva4XVe8FQUOtHmy7E1EiHEuCfw6O2km/PYSXTfoPNinDeoyENGuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777021178; c=relaxed/simple;
	bh=yl2fmbGX4lsYfOhvnCmEhE/7cHsEaOtMAP6LdlEL0fs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sFvF8ALWYEeP8uT6g/4OW/TahaTIbbDUpJO6bXeEG8ArloQOLr49STYSs6YBA2bRjCL38Zj/Ywy8hV1sl5+g8f3fgwGWkmR5pXSyrAgnPdg9j6V0r3birLOtfoVQJJHNjrE+GyZXugPWQE3BqEpCT1SzlFsJr3j1iE4fJo+ttAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRCG84/h; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso57105285e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2026 01:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777021176; x=1777625976; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoyg8FMw0CwqCK8I4nG4squLxWdTJlKOwqwgr4RUV68=;
        b=dRCG84/hepWT4ZPsQgVkpy4WIR8uKy5KwP5HN3fjKYwPLvVx8ebr7QOHb741HO2NnX
         FqaHkV4epXeNWyec2Lki5JpR1Zy4PeSDGoVGcAEF2JgtacxnQW6JUHttSfi8sH4jYPZU
         Qzgp6YKceTsKW8CVgv2LgeOyvri+OAF6e2LnRppp+QqbOEcX9Sl+MQPW7IpyRETIS8zV
         uCvXwH7eUKv4PXzrfxAl1vFa4WarqClkc3CRJcpzpwdpcJpjtnyGl55XQF428Jm1q3Fb
         Zk7Ub6qAFRj4bzx1BTH17917gT2krTwiLnoe2l8OEL419WPwVSbz2p9K7axiLhUxVgcZ
         xWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777021176; x=1777625976;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoyg8FMw0CwqCK8I4nG4squLxWdTJlKOwqwgr4RUV68=;
        b=YJw/nCdzSxIc39+MXHevP8FOmV2Bes46/Mn3KsUtp2EdLrgBFnt7Rp1sR8bvk8CYpD
         I55i0KRw1oYkFIXDQlRgJ61MEfZFAE5j8ig6K7OlqvX6S0f6vasJRe1im0wCZqLGmbbH
         Aqx+h19zeJotjxxSZQRUL5uQOFXbheKJIKU31kFt19oCvOme1UxtShKv68JGm0EsBZiM
         W1xODnZesQZnvyT01zva6imuXS6PwZS2bNnO8Zu/zB45OtHW9Q7UXsUcytOCEF8Ue25l
         uhE8Zer1q3LV/1q8aUIwo+Ga40YyEMWBS9myWEl5nCyNqfwsGk/G7ej33joTxGWCDpTM
         EiTg==
X-Gm-Message-State: AOJu0YwkOgRWOYq1NNS3/JgUkqRzbqrO+0fyR7F8sGtfgJng1o1fT2Vk
	L7kYZQ0nocB66kkaEsaHLCnukGh39X9pZ4WbRhxT6bLr7bwQAQS46qwSAGjPyh8L
X-Gm-Gg: AeBDiesnu9pyiiO4OsVgNK8paxuPhhaF4KgniBk2A6P6pT/orkyajIk+7I0zySBt/Q+
	ne7BE6qj53oaNVSnuA+LOP30gfyI3e7pioRi/omd7uaIvQ5vRZhA3xBtqZb2uaHIaCIM6YHm+IR
	lzJfGpfpJO5xzcfWINrqczMwWQ9yYph0a/2uXzQE8c5mMBh+Az6JVe4huyfmvUdHyaohTpO04d6
	JnpMUJpzo5JXzFJPO5jHW6SO6G/raiun7cKxL6WNbr++eIC13TXhrrkYtVofhauY1WIDqdymKyq
	4OBFzlHQj1t1/1ujBbKQRyZHPjLACinlofdY0OrrJGQMAtadJnlVJWb2XNoTxJ13HLSF3ELKgnc
	h62e46wLTFaX/IfLPiDeOgSFXUqMRo5C2DANI5sqUJ1+42eA3mejZ8qmx0NTNG9sp2EMuscLjEw
	WEVx2h8FdDTx5kV55+5ywiWARyrRZBHQ==
X-Received: by 2002:a05:600c:a105:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-488fb7786e4mr333909925e9.19.1777021175566;
        Fri, 24 Apr 2026 01:59:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c7a2sm180838455e9.1.2026.04.24.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 01:59:35 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:59:31 +0300
From: Dan Carpenter <error27@gmail.com>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
Subject: [bug report] wifi: ath12k: Add support for reading variant from ACPI
 to download board data file
Message-ID: <aesw8xC4txXCTlw-@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2C72545BD14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35266-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello Lingbo Kong,

Commit 0a43c3a520e9 ("wifi: ath12k: Add support for reading variant
from ACPI to download board data file") from Jan 13, 2025
(linux-next), leads to the following Smatch static checker warning:

	drivers/net/wireless/ath/ath12k/acpi.c:395 ath12k_acpi_start()
	warn: set error code if 'ab->acpi.bdf_string[0] == 0'

drivers/net/wireless/ath/ath12k/acpi.c
    351 int ath12k_acpi_start(struct ath12k_base *ab)
    352 {
    353         acpi_status status;
    354         int ret;
    355 
    356         ab->acpi.acpi_tas_enable = false;
    357         ab->acpi.acpi_disable_11be = false;
    358         ab->acpi.acpi_disable_rfkill = false;
    359         ab->acpi.acpi_bios_sar_enable = false;
    360         ab->acpi.acpi_cca_enable = false;
    361         ab->acpi.acpi_band_edge_enable = false;
    362         ab->acpi.acpi_enable_bdf = false;
    363         ab->acpi.bdf_string[0] = '\0';
    364 
    365         if (!ab->hw_params->acpi_guid)
    366                 /* not supported with this hardware */
    367                 return 0;
    368 
    369         ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_SUPPORT_FUNCS);
    370         if (ret) {
    371                 ath12k_dbg(ab, ATH12K_DBG_BOOT, "failed to get ACPI DSM data: %d\n", ret);
    372                 return ret;
    373         }
    374 
    375         if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_DISABLE_FLAG)) {
    376                 ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_DISABLE_FLAG);
    377                 if (ret) {
    378                         ath12k_warn(ab, "failed to get ACPI DISABLE FLAG: %d\n", ret);
    379                         return ret;
    380                 }
    381 
    382                 if (ATH12K_ACPI_CHEK_BIT_VALID(ab->acpi,
    383                                                ATH12K_ACPI_DSM_DISABLE_11BE_BIT))
    384                         ab->acpi.acpi_disable_11be = true;
    385 
    386                 if (!ATH12K_ACPI_CHEK_BIT_VALID(ab->acpi,
    387                                                 ATH12K_ACPI_DSM_DISABLE_RFKILL_BIT))
    388                         ab->acpi.acpi_disable_rfkill = true;
    389         }
    390 
    391         if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_BDF_EXT)) {
    392                 ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_BDF_EXT);
    393                 if (ret || ab->acpi.bdf_string[0] == '\0') {
                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Should we set the error code for an empty string?

    394                         ath12k_warn(ab, "failed to get ACPI BDF EXT: %d\n", ret);
--> 395                         return ret;
    396                 }
    397 
    398                 ab->acpi.acpi_enable_bdf = true;
    399         }
    400 
    401         if (ATH12K_ACPI_FUNC_BIT_VALID(ab->acpi, ATH12K_ACPI_FUNC_BIT_TAS_CFG)) {
    402                 ret = ath12k_acpi_dsm_get_data(ab, ATH12K_ACPI_DSM_FUNC_TAS_CFG);
    403                 if (ret) {
    404                         ath12k_warn(ab, "failed to get ACPI TAS config table: %d\n", ret);

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

