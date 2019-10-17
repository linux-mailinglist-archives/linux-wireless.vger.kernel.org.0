Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E913FDB06B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2019 16:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502992AbfJQOsn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Oct 2019 10:48:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41991 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502989AbfJQOsn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Oct 2019 10:48:43 -0400
Received: by mail-qk1-f194.google.com with SMTP id f16so2089308qkl.9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Oct 2019 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=vUJT2Qh/Q7E4yV5kXGaSdEDPkzP3Re2T3Ac8dtJnz60=;
        b=teFd2WnUU2jy7DXS8CqLyIcajpF40OQ5fc9H3SGfalFHeNPJIfvYzMT0s1vS75yGB7
         cNS1B+AnAwU41yRMfDdc3p2vNYg2ygg/1xscEAKYXycKkEE08DV5KQB3RguY5aX2a3NX
         eS/NCECfnNL6GbqFgK97YAw80JnEWtxVFyoAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=vUJT2Qh/Q7E4yV5kXGaSdEDPkzP3Re2T3Ac8dtJnz60=;
        b=pZI7kzlR8AkS6u+GLYMfszG4rgzah92QxEpyw/rXsC2+jF7ZIGRN7TIuG9OaCU0jfJ
         pH7STTGLpqB9pc9UU1oNE+7NN6B/zlTa6z+4vqZgWZNfAdV97l5tsdG1uyrwCpQPZh4U
         rIupzQ/3vuDhVyvkSUcJwbeYJmTQjvntFU1STfz4t90AfbYKjINgFWuMJ0mo1DwxKJUJ
         xYzumCpzYBCGS2KdqcBr8Fbuavh4OETKJGxCKIAjkwyLpiLFdlKdhPUHI7ZFk6679mzm
         RfwZyi+Rn3MaT9KdaDGfZCMtnElPig5cr8FMouTgvfBn+YpXKSnVM2wy4siopPXq5Dy8
         TPLQ==
X-Gm-Message-State: APjAAAWnoaGFBbzW3OlgFuPwRI74uOC9SfP3TywV0uvLUOq/T24WzrJx
        t6vZ69c3Zk7NB5izQ6fQIzZ8BKAgCONLY+da
X-Google-Smtp-Source: APXvYqxebP0akxMPP2wAUUOeB7/IWHZ7DQyZW4MDIfdmVe+Eis/SfqpcRGSxVQbAO1uKi9Cn5cxg7w==
X-Received: by 2002:a05:620a:98b:: with SMTP id x11mr3646910qkx.257.1571323722496;
        Thu, 17 Oct 2019 07:48:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::b253])
        by smtp.gmail.com with ESMTPSA id s16sm1039070qkg.40.2019.10.17.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 07:48:41 -0700 (PDT)
Date:   Thu, 17 Oct 2019 10:48:41 -0400
From:   Chris Down <chris@chrisdown.name>
To:     linux-wireless@vger.kernel.org
Cc:     Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: Don't IWL_WARN on FW reconfiguration
Message-ID: <20191017144841.GA16393@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

IWL_WARN seems excessive here since this can happen during normal
operation. Every time I connect to a new network with 8086:24fd I get
this as KERN_WARNING on the console, which mildly distracts from other
more pressing messages. For example:

    % sudo journalctl _TRANSPORT=kernel | grep -c 'FW already configured'
    403

Signed-off-by: Chris Down <chris@chrisdown.name>
Cc: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 5c8602de9168..ac7ecb76d964 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2264,7 +2264,7 @@ int iwl_fw_start_dbg_conf(struct iwl_fw_runtime *fwrt, u8 conf_id)
 		return -EINVAL;
 
 	if (fwrt->dump.conf != FW_DBG_INVALID)
-		IWL_WARN(fwrt, "FW already configured (%d) - re-configuring\n",
+		IWL_INFO(fwrt, "FW already configured (%d) - re-configuring\n",
 			 fwrt->dump.conf);
 
 	/* Send all HCMDs for configuring the FW debug */
-- 
2.23.0

