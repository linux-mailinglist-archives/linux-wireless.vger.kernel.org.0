Return-Path: <linux-wireless+bounces-18307-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6771DA261DC
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E18C77A3174
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Feb 2025 17:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A0120D51A;
	Mon,  3 Feb 2025 17:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ak0EoQUq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B520CCC2;
	Mon,  3 Feb 2025 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738605584; cv=none; b=OMiiDCAbkHPRlGYrTLiCangc9D+OVtyKJgf2tac9Vok1s5nuaxHMbQ9UrIeykRT+TIPi93lkiAOjESTt0i8uDV8I7Xpc9l+xOp7tj/t3K6RXr/8BYtxj4cpC/qHBcY5yoS0z7cB4P23s1GEVi8qnahA13ew7N9xgnBg7c2FtFI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738605584; c=relaxed/simple;
	bh=bHOp0QUrMuogWHVDOqjCZX+gH2Orn1MzQQkMPVmxQ+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0TVu91dcAKiDkmPTd+ZPpZeatweCPcJE8fH1cKwStaSufAAju9sQXQ+6cS295ohzBbFvaRhia1maXVum/xsvWWjKh/mdH0fmc8GVUy6/mMdMxitBh9Y4yRSS3D2lwJfwux/KNnHuTS9kL2oTN1U7TnFmQPSRaKZKSBM5nhdmqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ak0EoQUq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3862d6d5765so2483042f8f.3;
        Mon, 03 Feb 2025 09:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738605579; x=1739210379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cawTWtf8oPVLDrUkrYoMuQNnqZbL3O9HeB89EuCja7U=;
        b=ak0EoQUqs/yD0W+FN2Rxj6ca93jXC948eo7rW4Q6k8d+nm2rI/gCx1T+or8SHvnfdT
         s01RL7PhxW6kIJps1jASRSjTIjuSsb+t5HGcY6KZdiW0bPLemoD1BR1pUy6PFJ+BiWSh
         kQLX90LmRcU9grSWb0zrA3axHRuBKs2yUNiFROaSePO0DfvMzbz8ymt/IrWCqbLHJe6Q
         IClJ1css88+ehwfWT03kZLKy3bbVDqvhyHK9OPs3xpi6s3YgsPTZcNArEgvGCMyvQ4B/
         mdaA/y+yvZTmtJPyc8eyIehb3DQ11mXGSEmsfgUcqR1e8DMoVDmmET7bBQY02Ch5flFA
         msZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738605579; x=1739210379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cawTWtf8oPVLDrUkrYoMuQNnqZbL3O9HeB89EuCja7U=;
        b=klF/JL7PsDL+xXv7LEu1ppGWsAuHbrs+muL9DTnmlcTTHNRfDWip7qpP0ii7TK6+W7
         ClEGFeWQPdVTJDxjNaze3zvBHwidasJxOw5ZnJgzW2JGyuhy00Ph5JjXLp+v3zSgStor
         U63FfRtX92y06h35XUVPXOGkWmEx3NTlh5ly0wDxVtuZAuNNynirb0noWN6HPxktcHsc
         VeeNRz1d5SXa5MXMXUAHWq865XONSNjz1fMh8ay+U0zdHCUCjuukFhp11sBjd5XSwrPF
         yaOjy5H8zH/DLFIBVkxBMGo2zdWtGIDsw4/etN3S3XICfCGCLSqrv65eoYLXCk7jMQkz
         3dig==
X-Forwarded-Encrypted: i=1; AJvYcCVE9ABQ9fS2uZha+zZ1YgpffJ+/xHMWDbiXR9HigVoMj2nVm2KBNy2dbKm0DkMowD5DmlieUIh1RDDtvai2fZY=@vger.kernel.org, AJvYcCVHN19BfLn+kncZH/RKY7P9Vw0v7FCahN7dpSohP9v7Cl9PqbaYBW4QZB+3us0Uh0oMl5YcC9PQZ36E01ER@vger.kernel.org
X-Gm-Message-State: AOJu0YylAECCqZsDACy774ySnSNX9jWVQjfCidSi1Jk+HKUD2AsdsUOw
	lRPbVjscAQuNqCYPQeNt09MXnvWPhI77HfeVlVTdKKXKdXp+gkoU
X-Gm-Gg: ASbGnct4j7WGVoibhvshqtU7Qw+eBMa9d31xk+KRqWmCrU5S6rGdaijOOdIVlv/NH7F
	b/dtthnFgmaQ4cOzqjIi/56pQs6v5NZK+byvT9RNc8BclR+Tdlj8eBbHsNy+UZch/5+KHrt+S5H
	eEeElNk/+JcCrslwVYTEBMx9u4NwqXQVb0rlSlQbnrdYS+SnweWg3aOzwTEunwKDo8lM0lX3SiD
	FnqiwGuBrOoaWAJel6Z9nMwiFw6mVMwBvhE5ixWuWuzzHaicmP59AfFqZFhsDloLdhbCukM1dE4
	abRMjxLwGwhR3VhE
X-Google-Smtp-Source: AGHT+IGeinNHnhJtiqaajyHesWJ+5C8zkEwFfCR8tg4FWfMeuhnH2qwTG/FWDN+nrATLGwVPMKFwFQ==
X-Received: by 2002:a5d:694f:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38c520bfa02mr15179849f8f.53.1738605578603;
        Mon, 03 Feb 2025 09:59:38 -0800 (PST)
Received: from void.cudy.net ([46.210.194.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244f0d2sm166484425e9.30.2025.02.03.09.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 09:59:38 -0800 (PST)
From: Andrew Kreimer <algonell@gmail.com>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH net-next] wifi: iwlwifi: mvm: Fix typos
Date: Mon,  3 Feb 2025 19:59:05 +0200
Message-ID: <20250203175931.4795-1-algonell@gmail.com>
X-Mailer: git-send-email 2.48.1.91.g5f8f7081f7
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in comments/messages:
 - Increate -> Increase
 - intenally -> internally
 - stopp -> stop

Fix them via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c  |  4 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index a8c4e354e2ce..fd37e9dc9e0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -1783,7 +1783,7 @@ static enum rs_action rs_get_rate_action(struct iwl_mvm *mvm,
 	if ((high_tpt != IWL_INVALID_VALUE) &&
 	    (high_tpt > current_tpt)) {
 		IWL_DEBUG_RATE(mvm,
-			       "Higher rate is better. Increate rate\n");
+			       "Higher rate is better. Increase rate\n");
 		return RS_ACTION_UPSCALE;
 	}
 
@@ -3125,7 +3125,7 @@ static void __iwl_mvm_rs_tx_status(struct iwl_mvm *mvm,
 			       "tx resp color 0x%x does not match 0x%x\n",
 			       lq_color, LQ_FLAG_COLOR_GET(table->flags));
 
-		/* Since rates mis-match, the last LQ command may have failed.
+		/* Since rates mismatch, the last LQ command may have failed.
 		 * After IWL_MISSED_RATE_MAX mis-matches, resync the uCode with
 		 * ... driver.
 		 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 7a4844ec3c10..a246f1e4f5a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1113,7 +1113,7 @@ static void iwl_mvm_unshare_queue(struct iwl_mvm *mvm, int queue)
 					    "TXQ #%d is now aggregated again\n",
 					    queue);
 
-			/* Mark queue intenally as aggregating again */
+			/* Mark queue internally as aggregating again */
 			iwl_trans_txq_set_shared_mode(mvm->trans, queue, false);
 		}
 	}
@@ -2801,7 +2801,7 @@ static int iwl_mvm_fw_baid_op_sta(struct iwl_mvm *mvm,
 	switch (status & IWL_ADD_STA_STATUS_MASK) {
 	case ADD_STA_SUCCESS:
 		IWL_DEBUG_HT(mvm, "RX BA Session %sed in fw\n",
-			     start ? "start" : "stopp");
+			     start ? "start" : "stop");
 		if (WARN_ON(start && iwl_mvm_has_new_rx_api(mvm) &&
 			    !(status & IWL_ADD_STA_BAID_VALID_MASK)))
 			return -EINVAL;
@@ -2811,7 +2811,7 @@ static int iwl_mvm_fw_baid_op_sta(struct iwl_mvm *mvm,
 		return -ENOSPC;
 	default:
 		IWL_ERR(mvm, "RX BA Session failed %sing, status 0x%x\n",
-			start ? "start" : "stopp", status);
+			start ? "start" : "stop", status);
 		return -EIO;
 	}
 }
@@ -2861,7 +2861,7 @@ static int iwl_mvm_fw_baid_op_cmd(struct iwl_mvm *mvm,
 	}
 
 	IWL_DEBUG_HT(mvm, "RX BA Session %sed in fw\n",
-		     start ? "start" : "stopp");
+		     start ? "start" : "stop");
 
 	if (baid < 0 || baid >= ARRAY_SIZE(mvm->baid_map))
 		return -EINVAL;
@@ -3059,7 +3059,7 @@ int iwl_mvm_sta_tx_agg(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	default:
 		ret = -EIO;
 		IWL_ERR(mvm, "TX BA Session failed %sing, status 0x%x\n",
-			start ? "start" : "stopp", status);
+			start ? "start" : "stop", status);
 		break;
 	}
 
-- 
2.48.1.91.g5f8f7081f7


