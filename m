Return-Path: <linux-wireless+bounces-4192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00A86B041
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 14:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D151C22B37
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 13:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5555B14D456;
	Wed, 28 Feb 2024 13:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="Ee3iHvMY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18C14AD2D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 13:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126839; cv=none; b=kO10X4BXaKjSHLGJN/HeKekcet6178BcNGTM3pmKV8TEJQtHQwtzyqdWcW7ohmaPqTei7aoKIyLlCfrqtC3rzGq/tEu0Y/T71tPB2cHoChlsf4NhnMomdqy0eHbe8rBtfONs+RsEJTFSq+GirXiLBiEWFMtbjcU+PJlBqScDSQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126839; c=relaxed/simple;
	bh=Icdw8WPMFTifsyWlLBRow7hTpkm0GUlEzo8xGNbISYc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lvGkL732NJNGN5oG61/JBfDvSvVB0qDJJU+r5odq3buc9ugoWBlP8swIEhUuYXmDz8sGWLiYnDCObAG8kZx3AfdqJRG3UrljdQ0RbiZtBt2DF100914RMLm7+l06Y9xQSwzJe1u+jIX+gf2Si9j/3VEVZZFD5MJ+mtqgZ2jazyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=Ee3iHvMY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso162427666b.1
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 05:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1709126836; x=1709731636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b9XPJO7rlQBlp2t51YDB1EGQoKfjBIBca4L4WINiZhQ=;
        b=Ee3iHvMYQqxeiL1CgqxGYX8DrVvvCcQ5NIDwvstSA1NsWu6R3qykhpfwZYfb1GXYPp
         ZwFJ9XQ5eYV0ZVGGOGIiS71QZcxDZhcD+gyAXGfjhm34nCV/NNfljcjPN2wyguSiAuXH
         Rt/UXbZJDR6XPBM1b0xbnURiOCMFa9geJLqeXR0Gv0PhFvhsxerTu8iVWagVTggp1NG+
         BjyvRsT5V7OHbJrGhQT/GbbiEl92egjvJi/TAu1Bj5VgFr5NH1FXyupvdYbjT6sH/yFI
         42GpLV4IUgKNElWnn1IP+SQ6NrvDerRXX/vVKfbbPuksrKdOYqEgtv2OtStazX7jopFI
         QRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709126836; x=1709731636;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b9XPJO7rlQBlp2t51YDB1EGQoKfjBIBca4L4WINiZhQ=;
        b=BLYbzlP6YMo+aC557vlj4FMEbvaDf1Q0jya0RWNAOzzaPyv/qqvaWaBnmuR5DRNRP7
         xwtO2U75RbybN2uRTzlJ4J5uthpwzMiT8H+n0pjM5Ri/t5MyWToj6eiVjE9nLP7o1gE1
         qntlCiQZtc843gc93HlzxkEyUeJZspxS6nnn3dWm29xA0IgYwz8YGQWENA6iI9BDBg2K
         ztLSMgWGUz4cYW5pxQilrOYyKA+ns1DEVw0189P1JlPT6So3we9cwgyhvhFjVufCHHkX
         I/fXHJxrFlJWCMIOrMYNxn/iAUamaP59pbiJxqM/uFvEr0uDbmgEkgE5h3gqb2dt9/UQ
         UUeA==
X-Gm-Message-State: AOJu0Ywoq1I4apa7RlecempY9odlSMG3hrOC3YFELRJGMtiWaIG2VyqT
	DdY7NV33Jtl6dySQeo4c8grU1wcFAkWo1vgnD03udecVXkh8VRsIG3ZY3zY/Pyo=
X-Google-Smtp-Source: AGHT+IHBq9tBWWcAxJtiydUcMmsGN4VjdQJ0kgVN2GaOpI5Vp1/hOhyXh0khuVAVbkqmVqLQ1ttCsA==
X-Received: by 2002:a17:906:7712:b0:a3e:53d9:c7d5 with SMTP id q18-20020a170906771200b00a3e53d9c7d5mr2133878ejm.36.1709126835730;
        Wed, 28 Feb 2024 05:27:15 -0800 (PST)
Received: from ?IPV6:2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456? ([2a02:8428:2a4:1a01:6dfa:263f:dd7e:9456])
        by smtp.gmail.com with ESMTPSA id s6-20020a1709060c0600b00a42e4b5ab00sm1839417ejf.41.2024.02.28.05.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 05:27:15 -0800 (PST)
Message-ID: <dd4b3fa0-b7f6-4115-ba12-5e5154ae9a79@freebox.fr>
Date: Wed, 28 Feb 2024 14:25:45 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: ath10k: work around missing MSA_READY indicator
Content-Language: en-US
From: Marc Gonzalez <mgonzalez@freebox.fr>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>,
 ath10k <ath10k@lists.infradead.org>
Cc: wireless <linux-wireless@vger.kernel.org>, DT
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Pierre-Hugues Husson <phhusson@freebox.fr>
References: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
In-Reply-To: <14daa98e-7fd3-4ebb-87bb-5d2c1fba679f@freebox.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

From: Pierre-Hugues Husson <phhusson@freebox.fr>

On our APQ8998 device, driver never receives MSA_READY indicator.
We only seem to receive FW_READY and PIN_CONNECT indicators.
Not waiting for the MSA_READY indicator seems to fix the WiFi.

Signed-off-by: Pierre-Hugues Husson <phhusson@freebox.fr>
Signed-off-by: Marc Gonzalez <mgonzalez@freebox.fr>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 5 +++++
 drivers/net/wireless/ath/ath10k/qmi.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 38e939f572a9e..c7724a3588549 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -1040,6 +1040,8 @@ static void ath10k_qmi_driver_event_work(struct work_struct *work)
 		switch (event->type) {
 		case ATH10K_QMI_EVENT_SERVER_ARRIVE:
 			ath10k_qmi_event_server_arrive(qmi);
+			if (qmi->skip_msa_ready)
+				ath10k_qmi_event_msa_ready(qmi);
 			break;
 		case ATH10K_QMI_EVENT_SERVER_EXIT:
 			ath10k_qmi_event_server_exit(qmi);
@@ -1077,6 +1079,9 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
 		qmi->msa_fixed_perm = true;
 
+	if (of_property_read_bool(dev->of_node, "qcom,no-msa-ready-indicator"))
+		qmi->skip_msa_ready = true;
+
 	ret = qmi_handle_init(&qmi->qmi_hdl,
 			      WLFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_MSG_LEN,
 			      &ath10k_qmi_ops, qmi_msg_handler);
diff --git a/drivers/net/wireless/ath/ath10k/qmi.h b/drivers/net/wireless/ath/ath10k/qmi.h
index 89464239fe96a..3622714a405bb 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.h
+++ b/drivers/net/wireless/ath/ath10k/qmi.h
@@ -107,6 +107,7 @@ struct ath10k_qmi {
 	char fw_build_timestamp[MAX_TIMESTAMP_LEN + 1];
 	struct ath10k_qmi_cal_data cal_data[MAX_NUM_CAL_V01];
 	bool msa_fixed_perm;
+	bool skip_msa_ready;
 	enum ath10k_qmi_state state;
 };
 
-- 
2.34.1


