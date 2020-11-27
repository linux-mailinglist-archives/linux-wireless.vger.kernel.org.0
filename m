Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66D2C6B55
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Nov 2020 19:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbgK0SHT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Nov 2020 13:07:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29447 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730675AbgK0SHT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Nov 2020 13:07:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606500438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=H7PcvPg+i5XoUPzJor4eQ+x6uH9OtzkraZC8rlH6KWc=;
        b=Sd6qm5sVs0pBC29sQ05iQg33dlr7sop+KCab0CrMRg9A3TRRZ+LGgq1GO8DOFRgqJsYShn
        0LPG7KY9KEfcAidQdlC7gdKXOhdmU8YEoCRyN+DO5aE/Hwf1tApRi7ghHoevKysYjz4lrL
        gy3J27PzTpx7IW3pKEEsya//LG3zgMY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-X2ymh5veOL-gE6VNB6B68g-1; Fri, 27 Nov 2020 13:07:16 -0500
X-MC-Unique: X2ymh5veOL-gE6VNB6B68g-1
Received: by mail-qt1-f198.google.com with SMTP id x62so247998qtd.11
        for <linux-wireless@vger.kernel.org>; Fri, 27 Nov 2020 10:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H7PcvPg+i5XoUPzJor4eQ+x6uH9OtzkraZC8rlH6KWc=;
        b=MbXeBfvUFtDpw4R1xzEj+zcbxwjFnVVHD5LuTyO1sBA+o0O484LMukENamrozdfngr
         dS/KCuplPkTSaEb2YGyzlx+EW/2L6l/2BOaJTkLWpr+Y29gbEmpIEevy9DowNhgp2YbU
         X/o9g+ApErqCTZ+bnkaiArEpJmC4qMg5Uuf17/YXqY8847aDt3ML9XRDImxLUFMcqj4o
         UwOyXXO2ZiD4HiRaWi7YoVu22GbF+dNSwZmXoUYmidQ/vagPRQZCmBJ5o7v+hVRADDsy
         SWSwhood1V4B4g6KwW45Cz4nNvujIuNTc//2jl8irZC6quPUFw9JQtdxmGelYkOLa6ml
         v3KA==
X-Gm-Message-State: AOAM530zSVeOe6PSwUFyz19gwSrwSKx9veW7SPofVA+cukrRciNzuUcg
        swgOu/MdxsHrbUUMBcHvUwsoQT6X5A3FYCOCWLAYhKC5lHVnbZFROkbIfOmfNIsXv9GqxTyWIxr
        2lZbx4ZRrrzThYpiYedgS3OazwY8=
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr9497610qta.364.1606500436290;
        Fri, 27 Nov 2020 10:07:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrczAlHXv6AxBn4va9GpnW6SljlzQRkczv7FkNfINZgV5uL21V1Nx739W7zcwEcXppYH5Pjg==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr9497583qta.364.1606500436056;
        Fri, 27 Nov 2020 10:07:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r127sm6740373qke.64.2020.11.27.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:07:15 -0800 (PST)
From:   trix@redhat.com
To:     johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        luciano.coelho@intel.com, linuxwifi@intel.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        lee.jones@linaro.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: iwlwifi: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:07:09 -0800
Message-Id: <20201127180709.2766925-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 9d55ece05020..7b2f71e48c97 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -318,7 +318,7 @@ iwlagn_accumulative_statistics(struct iwl_priv *priv,
 		    (__le32 *)&priv->delta_stats._name,		\
 		    (__le32 *)&priv->max_delta_stats._name,	\
 		    (__le32 *)&priv->accum_stats._name,		\
-		    sizeof(*_name));
+		    sizeof(*_name))
 
 	ACCUM(common);
 	ACCUM(rx_non_phy);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index 68060085010f..8f7c9b7eeeac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -199,7 +199,7 @@ enum iwl_bt_mxbox_dw3 {
 					 "\t%s: %d%s",			    \
 					 #_field,			    \
 					 BT_MBOX_MSG(notif, _num, _field),  \
-					 true ? "\n" : ", ");
+					 true ? "\n" : ", ")
 enum iwl_bt_activity_grading {
 	BT_OFF			= 0,
 	BT_ON_NO_CONNECTION	= 1,
-- 
2.18.4

