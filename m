Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0496B3F2A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Mar 2023 13:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjCJMa7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Mar 2023 07:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCJMa4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Mar 2023 07:30:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8288110A295
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 04:30:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l7-20020a05600c1d0700b003eb5e6d906bso3288675wms.5
        for <linux-wireless@vger.kernel.org>; Fri, 10 Mar 2023 04:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678451453;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2/6GqSvqjpN9/kGxk58IRPrMjyDQK6wh4sOY8yWXLFE=;
        b=MpU3vjNAATCaTSPKSD6XTLUk5/fbNy3MFeDpJtOrvTalsDdHFfGCi+I5ALDVtjZlZJ
         D/Z+e4TFC1WY/eZVDfCDDEbMKEXUZosRhxWhFgXonw4At43iAlnWO+VBaTloIdNSw2Jg
         giV9U3L1mNIT93ZaQrVHyGVe1AR5L3/CpZOEN+na0vUvf73T9YPdfMLNhY+Ac23UKzNg
         FL+dVJMjRHpK9RTiE68Uqbt9BzswgPKF/2oqdSi4OIwbANwqD5D0z18oN0lwSsYp66Vu
         HKKrZDeq6FrdbdTm2OWw0o13pbe8fdtFm369MtPgowSOitagYK/YJ8Lg1woaeJ90ZWbT
         oaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678451453;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2/6GqSvqjpN9/kGxk58IRPrMjyDQK6wh4sOY8yWXLFE=;
        b=Br//3rQy4GQuCZ2y6RVDyuopxj0XWMRWHMKtfSouv0l/y/4oNknMQIuSvmDgOy3caf
         gtRJffU6ydlLmJu87SWIXFVCezRloeYImAPoEpYZF7ePY3Rr+v33Iu8TR+W8hwMXthGC
         CxVEkpzdkvS/xqEwkm61G/8MU+BNvFj9fOsgPPypxF3jLeLQEp24nspjkR9+fLIVt6F+
         z8QrWRBFnfGD66CFa6PHQ4sRtJPT3NF7o9JBsSY8eYG6N8YnUuatuQmXIF8k+amW1RVm
         gHTITSTmo/M0lc+anfSIbabjHwpZJW8DPQb9+zfWdwGQOCHOc6sUO9HfCnU5gUEQvc68
         EHcA==
X-Gm-Message-State: AO0yUKV8NAD5tE4jsN0sC9H260hdHSF9ytAk2rTPsZ+5TTHvOaE+KqTU
        +5Vq6SiYbB5L/MkpsCUq3HMJTwGZm5c=
X-Google-Smtp-Source: AK7set/H/xFsA1THgmmK2yMEO2t7/my16pwcuzo02IdiB2HrT0vXAf9bDsjYKcZhfLUczsofWZvrNw==
X-Received: by 2002:a05:600c:1d86:b0:3eb:3998:36f7 with SMTP id p6-20020a05600c1d8600b003eb399836f7mr2471826wms.8.1678451452914;
        Fri, 10 Mar 2023 04:30:52 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003eb596cbc54sm2100403wml.0.2023.03.10.04.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:30:52 -0800 (PST)
Date:   Fri, 10 Mar 2023 15:30:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     marcan@marcan.st
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: [bug report] wifi: brcmfmac: acpi: Add support for fetching Apple
 ACPI properties
Message-ID: <8b390eea-674e-4c80-a296-35c7f6843691@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello Hector Martin,

The patch 0f485805d008: "wifi: brcmfmac: acpi: Add support for
fetching Apple ACPI properties" from Feb 14, 2023, leads to the
following Smatch static checker warning:

	drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c:22 brcmf_acpi_probe()
	warn: passing negative value to 'ACPI_FAILURE((-71))'

drivers/net/wireless/broadcom/brcm80211/brcmfmac/acpi.c
    11 void brcmf_acpi_probe(struct device *dev, enum brcmf_bus_type bus_type,
    12                       struct brcmf_mp_device *settings)
    13 {
    14         acpi_status status;
    15         const union acpi_object *o;
    16         struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
    17         struct acpi_device *adev = ACPI_COMPANION(dev);
    18 
    19         if (!adev)
    20                 return;
    21 
--> 22         if (!ACPI_FAILURE(acpi_dev_get_property(adev, "module-instance",
    23                                                 ACPI_TYPE_STRING, &o))) {

This doesn't affect run time, but acpi_dev_get_property() does not
return ACPI error codes, it returns normal kernel error codes.

    24                 brcmf_dbg(INFO, "ACPI module-instance=%s\n", o->string.pointer);
    25                 settings->board_type = devm_kasprintf(dev, GFP_KERNEL,
    26                                                       "apple,%s",
    27                                                       o->string.pointer);
    28         } else {
    29                 brcmf_dbg(INFO, "No ACPI module-instance\n");
    30                 return;
    31         }

regards,
dan carpenter
