Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE66B71A014
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Jun 2023 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjFAOdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Jun 2023 10:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjFAOdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Jun 2023 10:33:07 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E3ED1;
        Thu,  1 Jun 2023 07:33:06 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64fbfe0d037so1693405b3a.0;
        Thu, 01 Jun 2023 07:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685629985; x=1688221985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=StY7u7zFZoJx8ftOxCG8sLd5KVP7Rr142knr5iqMLGo=;
        b=m3mndgz9F4UUprvuR81e/IchfSiVcnCngvq7HfWSCcLLeS5voX+a40B7iXKzYU6sdc
         pOMgLsR8BPrUuMKgJWpFG2H/dJEyr13je9DOIAvMwVXQxd5dKxYoqslA/K0eHpmjNZba
         OlessJxoZZZq86J5mq6CLXTCT92j83gkurNgQfRjwzISEgwe9z5diYbfcJXh3JQjQRQL
         Axiiay2H6phYdZ7Gx5HZTjADfQTZSZx31Q9XlV3+ERSB9M7mEpOHCxqOCOPpgz444C0v
         1zjlUO0dmTywqWxUk7EF6L/0p06SqShLaTXjrponXdMTLYZ+3pqZf00zcLMMGg3At/H8
         TPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685629985; x=1688221985;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StY7u7zFZoJx8ftOxCG8sLd5KVP7Rr142knr5iqMLGo=;
        b=FAnVSfggO5lbV0lKRK3PZv1AqYQ90CcIxsPvbYvSB02JERyqepB5KpDCiaP57D6mt5
         d5E+jLAJwkKSe1dSEMXnfWX2oz9XQm+8TLBxiYvSC/duXAxjzEvxf68S1Add2BhMuvED
         jj1k3mzgaNMk/ODAaP9JP2dDDRhl2qbTWqbQdsLcJQfn+rg+sfK9byr2zOlJvpejdYPO
         i/biH+BiNjC951DgIDK+69AlfQqdOekNjwxpd6asdTgQmfrV6po5SpLODukg7v1vnBhP
         7ne9sg5miHjAMQOg1adK3ul57EX7rzEBRY5/2m7KR4j3DP6HPFSj0VcZG4z0UYA90jOP
         Ss+g==
X-Gm-Message-State: AC+VfDzhn3B1IeQcI0qGTjTK8Gxw8sCD1C+avWtc9zOx0ckhAPye0XH+
        v1+0wjHYEMBu1DU4W/Mwmrg=
X-Google-Smtp-Source: ACHHUZ4JEst91je62w0drRDh6m1h6+/uqOEUCfrceE1qz5Ixa7MQ9uGdCQrNEQ2ZpO3hRzMo6p3fYQ==
X-Received: by 2002:a05:6a20:3d87:b0:104:1016:dd0e with SMTP id s7-20020a056a203d8700b001041016dd0emr2556123pzi.3.1685629985203;
        Thu, 01 Jun 2023 07:33:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o27-20020a635a1b000000b0053fed3131e6sm1588221pgb.65.2023.06.01.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 07:33:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 1 Jun 2023 07:33:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        inux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlwifi: bump FW API to 78 for AX devices
Message-ID: <f7e417e0-5277-4085-bb50-fb43bdc52f7a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, Apr 17, 2023 at 11:41:34AM +0300, Gregory Greenman wrote:
> Start supporting API version 78 for AX devices.
> 

This patch sets the ucode version for a large number of devices
to 78, but ucode version 78 is not available for many of those
in linux-firmware. It seems that .78 was skipped for some devices
in linux-firmware, and the last version for several others is .77.

This causes problems when trying to validate if the firmware
listed in MODULE_FIRMWARE actually exists.

Is the missing firmware going to be available at some point,
is there a plan to fix the code to only list actually available
firmware, or is it a wrong assumption to expect that the
firmware listed in the kernel actually exists ?

Thanks,
Guenter

> Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
> Link: https://lore.kernel.org/r/20230417113648.5a4dcbf5a2c1.I125808566fe892ee0865e392bf1b1872daafe8ad@changeid
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/cfg/22000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> index b98f0ff02362..532d14f61253 100644
> --- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> +++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
> @@ -10,7 +10,7 @@
>  #include "fw/api/txq.h"
>  
>  /* Highest firmware API version supported */
> -#define IWL_22000_UCODE_API_MAX	77
> +#define IWL_22000_UCODE_API_MAX	78
>  
>  /* Lowest firmware API version supported */
>  #define IWL_22000_UCODE_API_MIN	39
> -- 
> 2.39.2
