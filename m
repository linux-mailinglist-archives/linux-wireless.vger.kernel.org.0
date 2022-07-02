Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2274E5640E9
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jul 2022 17:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiGBPKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jul 2022 11:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiGBPK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jul 2022 11:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9ED96BC3F
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jul 2022 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656774626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Cqp43LfXGvDDWLcjAcU0nNREspk+kElXMNXTMGJ8P1E=;
        b=F4lMUD5Wdfss+DZQLPqBh8Q7SInh8hHg2JCKe+XwVxakh6iQaOC7umpSMWP8BYoybLLOBN
        6Cv2bewxGzYJdXKMyyy0NuuzeZQVHdUuw5l2HRPKRQ/LFamv+hRdSig6kf3Nsfqu7o2EDp
        dxy+4lxjO51ssVql53afbRd4m/E3kpg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-yCAvJNCrMU6T4hvJurtT3A-1; Sat, 02 Jul 2022 11:10:25 -0400
X-MC-Unique: yCAvJNCrMU6T4hvJurtT3A-1
Received: by mail-qt1-f198.google.com with SMTP id c22-20020ac81116000000b0031d25923ea8so1857276qtj.17
        for <linux-wireless@vger.kernel.org>; Sat, 02 Jul 2022 08:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cqp43LfXGvDDWLcjAcU0nNREspk+kElXMNXTMGJ8P1E=;
        b=UGUClI+SWrt86DfMA92bNTAV5wid1AvVsJkTwhuUum75VfQPdMz/lXgBCEmDUad1oY
         y83hnhQppJ3mh/Yp3Fm+A0FyIhV16uQZERGRKBnbicRnfCwmrs8MN/bPeJqMVI3ydNR+
         uFNsDLFtLY5UuIU4r2q6kn3HIr55a4lDJZ1EkDTQk1ThZfF4zzLKAcIqvpW8EDlL3kgV
         i22CGBX3B+n8XACFIWF+ZZBO4fGhU+LmWjS9KZ96gEu1LuCGUN6RPwROKok519PIq2Jo
         GylTHtyccVED8RA1HIx7aloTRVXeDzcrQPewNszsV4qL0r7FdT2lLdtxUcM3F4nun1IK
         4s9Q==
X-Gm-Message-State: AJIora/V07Ri11stIpssmv3KI5snRxfP9HjTszyzNJaaj8wFasyYIJa+
        4JvaJRkDe0aMkFiupPwKNBVyDYQkGuOLN9YluAQg5h6PIF94wQ5Kg3vOdrk+qgSB3X0YLF4CQv6
        8oYckc970gXWCUhb5/vNwlso2lUU=
X-Received: by 2002:ac8:5816:0:b0:31d:4178:5fd0 with SMTP id g22-20020ac85816000000b0031d41785fd0mr1632040qtg.253.1656774624762;
        Sat, 02 Jul 2022 08:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vl3/Ai5Vps6cqyXNHSW43QW8v5SfQxKSachr4YHT8JFyALP6kBEa7qly/qiC2VBYhdMdg8Gg==
X-Received: by 2002:ac8:5816:0:b0:31d:4178:5fd0 with SMTP id g22-20020ac85816000000b0031d41785fd0mr1632016qtg.253.1656774624536;
        Sat, 02 Jul 2022 08:10:24 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id hh10-20020a05622a618a00b003154e7466casm16292230qtb.51.2022.07.02.08.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 08:10:23 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        nathan@kernel.org, ndesaulniers@google.com,
        luciano.coelho@intel.com, ayala.barazani@intel.com,
        miriam.rachel.korenblit@intel.com, johannes.berg@intel.com,
        matt.chen@intel.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iwlwifi: mvm: return an error if setting tbl_rev fails
Date:   Sat,  2 Jul 2022 11:10:20 -0400
Message-Id: <20220702151020.2524220-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

clang static analysis reports
drivers/net/wireless/intel/iwlwifi/fw/acpi.c:1048:17: warning: Assigned value is garbage or undefined [core.uninitialized.Assign]
        fwrt->ppag_ver = tbl_rev;
                       ^ ~~~~~~~
tbl_rev is optionaly set by a series of calls to iwl_acpi_get_wifi_pkg()
and then jumping to the read_table when a call is successful.  The
error case when all the call fails is not handled.  On all failed,
the code flow falls through to the read_table label.  Add an error
handler for the all fail case.

Fixes: e8e10a37c51c ("iwlwifi: acpi: move ppag code from mvm to fw/acpi")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index e6d64152c81a..1ef1e26c3206 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1044,6 +1044,9 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		goto read_table;
 	}
 
+	ret = -EINVAL;
+	goto out_free;
+
 read_table:
 	fwrt->ppag_ver = tbl_rev;
 	flags = &wifi_pkg->package.elements[1];
-- 
2.27.0

