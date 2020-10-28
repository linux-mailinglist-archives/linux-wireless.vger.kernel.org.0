Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA6C29DED8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Oct 2020 01:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgJ2A5A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Oct 2020 20:57:00 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:47723 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727525AbgJ2A4u (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Oct 2020 20:56:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603933010; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dJXERFtxZ5iCKoFx8EJT57roOLVsp5+AgsjLAdvm4+s=; b=D6VIqZknomb4cSLluvtoc6ulAd/oRJ4gb33gXzDrXcDRgDvn3yW4l3khpVr9W4HoXv34c7Xt
 YPwglMmht0wrWAJaH1D6InTNJWBh+jegXoI5i4MGD/VUl7w3ASLdAnNmQhXxmP/x2RIenSEn
 FxHYdvFz5WkMFquRRxQvqCLcw+w=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f99a3e45fd674d5f0173ac0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 28 Oct 2020 17:01:24
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 68F2CC43385; Wed, 28 Oct 2020 17:01:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6FF0DC433CB;
        Wed, 28 Oct 2020 17:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FF0DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuabhs@chromium.org, dianders@chromium.org,
        briannorris@chromium.org, Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2] ath10k: Fix the parsing error in service available event
Date:   Wed, 28 Oct 2020 22:31:09 +0530
Message-Id: <1603904469-598-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wmi service available event has been
extended to contain extra 128 bit for new services
to be indicated by firmware.

Currently the presence of any optional TLVs in
the wmi service available event leads to a parsing
error with the below error message:
ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71

The wmi service available event parsing should
not return error for the newly added optional TLV.
Fix this parsing for service available event message.

Tested-on: WCN3990 hw1.0 SNOC

Fixes: cea19a6ce8bf ("ath10k: add WMI_SERVICE_AVAILABLE_EVENT support")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
Changes from v1:
- Access service_map_ext only if this TLV was sent in service
  available event.
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
 drivers/net/wireless/ath/ath10k/wmi.c     | 5 +++--
 drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 932266d..7b58341 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1401,13 +1401,15 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
 
 	switch (tag) {
 	case WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT:
+		arg->service_map_ext_valid = true;
 		arg->service_map_ext_len = *(__le32 *)ptr;
 		arg->service_map_ext = ptr + sizeof(__le32);
 		return 0;
 	default:
 		break;
 	}
-	return -EPROTO;
+
+	return 0;
 }
 
 static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 1fa7107..2e4b561 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5751,8 +5751,9 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
 			    ret);
 	}
 
-	ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
-			       __le32_to_cpu(arg.service_map_ext_len));
+	if (arg.service_map_ext_valid)
+		ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
+				       __le32_to_cpu(arg.service_map_ext_len));
 }
 
 static int ath10k_wmi_event_temperature(struct ath10k *ar, struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 4898e19..66ecf09 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6917,6 +6917,7 @@ struct wmi_svc_rdy_ev_arg {
 };
 
 struct wmi_svc_avail_ev_arg {
+	bool service_map_ext_valid;
 	__le32 service_map_ext_len;
 	const __le32 *service_map_ext;
 };
-- 
2.7.4

