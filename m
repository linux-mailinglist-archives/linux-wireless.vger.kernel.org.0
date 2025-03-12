Return-Path: <linux-wireless+bounces-20219-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E21BA5D83A
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 09:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C423A70FE
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 08:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F308235364;
	Wed, 12 Mar 2025 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tbWrMUD6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCE21E51FF
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768308; cv=none; b=KtzBZbOMlCq8+xR4VxcwCYzHQuI8VMRrzU/JYSB7IwFTKXUj2kKbX1wcjSq1q2F10BQiD4TyF5AFDVy8d7s3pPlmx0AUJWCluf5iSmLnSkKh45X7t2oFrl4w8e1T/1XbkOoNqke4fzgnevAt3794MNciFRzh2IGEkINQcAiygB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768308; c=relaxed/simple;
	bh=FT1oxj0Qgt13l0mXa+EPVobcY1J9Jerp6oe4CFShQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WA/xsRBYOH/7o6+SuzfyaJtY4z4tF+7uTXT+ylJMbHOf/JboZePJlEUSYNzgopqUNiKe0LQJHSQKSJLKyKnK+1n9SquK0fD/9stS0U/Tky3ok4WJWxOF8wT6NiHe1rLnX7Qsg2Ut3qMm/KkhloX7keQMHDeDNVODQXOsxFCKaGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tbWrMUD6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f2f391864so3288768f8f.3
        for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 01:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741768304; x=1742373104; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJss9g7O/dMXFJMt3GukmQPPAokmf3Hhu32HSuWCJ2w=;
        b=tbWrMUD6ZoqMKKOfJoldMDr7uzKzfGE9XlHAePg5Vn2uLXXztXqM18I6NsspXiZp7S
         W59oWEzgwvSveEethtWfFCFuYsdQ1K7uCyQPEA/QxfEZke7IosMW8TVbjADg4/MccFyF
         ih16ClDgljIjn/y7+rrpzOjdMkSDRUIuwIjViBon2RbMfRXZ2eliDB4pGjNUDkdayOkz
         k70Hf1ubIEI9XuTO2ijLYtJwzFVjJS0eIcDIXzgzHMMYZvT0M5X0o++VLYREi1q4rHH+
         GLFIQnrkaYeucerXZT6saquM1iGgQzuaIZyJsGE+ujUctgZUkjXHueHAdy/IT1NY1EWq
         5xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741768304; x=1742373104;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJss9g7O/dMXFJMt3GukmQPPAokmf3Hhu32HSuWCJ2w=;
        b=nfZxCVi5z8te6UJejRP4WBvV838emU/l4rygxc/tBXlg3pid3KVdQSUeBqL0dFnJM/
         MYfgOcnTBmvWuiTuInwWbjzkyzK+XwrdXcI2Cl1mU84F9WMHtdJJbS9f3QQJkJXpMDye
         kO2MtZAorYbIJrSGLgeULg5WcPKJI5tNthdAusUfyTfGNJnVUFh1e6UVB3t0hghiY949
         j2B7y3nipTxG6UAIgNpLmGbBtHMyrtOEFL+d7EocHC12uqt7YD7IQWx3s9dpPEHdMPNQ
         i5wfZUvjkpanxuxZMg0Zv1y+ltc49dxGo89DJzTLJIsX82ROU+aj7q1A5nT9l3Q+Ho0z
         rbqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxNtXR8RcAN3//eNvcKNqX+CYRzFCd28u2JWUya26KZdzEIYthf418mhQdpeap0N9gu0UtjGrX3Dh9z/LrJw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc+XtUFd7rQbVwgYJtHJxUpWMk8C/Xp5maWoQFpYkyhTuSir2Z
	nsmt9r58+RdYMRZFQjmXrXFEumyJM8IkScZjrIiMzpwKKBitwNar7O0VrtWBe08=
X-Gm-Gg: ASbGncuA0DnIi35XXo5oQUI2sbQvSpkG5hr/bjJKOi6ajgCRBz6xoB1rw9hvImCAO5r
	YW7EPTQDkin2PSIUR3gsrHy5Vz/zJz3yKCFZTEBMrAG9F6YkGulD4KYqJEHKOInMp1+qPZS1Y4Z
	irQ8kafxp9RerpqIlPUDQ7iTFoqe+hFhpJNu87QJ6R6qKNoXY9HxAiyoTwDR16vCuqm5UZ0t/fC
	y74cfdUqIIyHcgsJ/TIRigEMOb7KDawpx7Hl+muldq7EQ9IHa/OWC3j2WRXqRgQS3J237LZINwB
	/ZG9nUb3ZhS3gRAnMbo1AtiY4HJyqshGI9TCIkqNxQYHQ4dw9g==
X-Google-Smtp-Source: AGHT+IGSSv9SOYrAJaJbwR1yeaga3JE6OR0syE92NYaNxFFvCniZMBgOzqpRGm8809U1/xszfdAp1g==
X-Received: by 2002:a5d:6d04:0:b0:390:f0ff:2bf8 with SMTP id ffacd0b85a97d-39132d05f78mr16351423f8f.10.1741768304183;
        Wed, 12 Mar 2025 01:31:44 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfba8b6sm20754870f8f.11.2025.03.12.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 01:31:43 -0700 (PDT)
Date: Wed, 12 Mar 2025 11:31:40 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>,
	Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Avraham Stern <avraham.stern@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] wifi: iwlwifi: Fix uninitialized variable with __free()
Message-ID: <f7c17a7f-f173-43bf-bc39-316b8adde349@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Pointers declared with the __free(kfree) attribute need to be initialized
because they will be passed to kfree() on every return path.  There are
two return statement before the "cmd" pointer is initialized so this
leads to an uninitialized variable bug.

Fixes: d1e879ec600f ("wifi: iwlwifi: add iwlmld sub-driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/wireless/intel/iwlwifi/mld/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
index c759c5c68dc0..1d4b2ad5d388 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/debugfs.c
@@ -556,8 +556,8 @@ iwl_dbgfs_vif_twt_setup_write(struct iwl_mld *mld, char *buf, size_t count,
 	};
 	struct ieee80211_vif *vif = data;
 	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_dhc_cmd *cmd __free(kfree) = NULL;
 	struct iwl_dhc_twt_operation *dhc_twt_cmd;
-	struct iwl_dhc_cmd *cmd __free(kfree);
 	u64 target_wake_time;
 	u32 twt_operation, interval_exp, interval_mantissa, min_wake_duration;
 	u8 trigger, flow_type, flow_id, protection, tenth_param;
-- 
2.47.2


