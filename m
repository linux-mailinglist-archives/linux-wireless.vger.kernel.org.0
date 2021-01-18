Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C922F9EBC
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jan 2021 12:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390982AbhARLuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jan 2021 06:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390941AbhARLuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jan 2021 06:50:25 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD20C061573
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jan 2021 03:49:45 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hs11so20945544ejc.1
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jan 2021 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=TOTP066HoV3zrlO1R4iH0ZuR58PSnBoIUmJpWoBcZsc=;
        b=hx0RRaTa0YqTeI2N940kV8iDO67Ep1kA2/WRdk1irVts/iqPOCDIPc2rXsJU+Fvzq3
         VLgbkVyU7a2xDu5qhwjg2knjazCiC8Iw8UvabZpW58OMlSvlfaoh0K3XbIrXXM+8UUKl
         jDtGu94DQv2w/ATzdh2e1QDxAkt6TRFMrYpDSZKK2q9GGPQ8WxYJvglUxfZHghp070PR
         sxBfZd8FNCj+ZCEgg+EuoPnxjwS0CVriIiL5I2d9dZleYlv4pdOurdExV9wbJV2wYtY8
         NjKMLG2G6yHnzj7YB2EvJTyWJn03yKisl3Q8v0HnTrYLtjgZTWw55vZuk+4bO0uS+XxM
         DhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=TOTP066HoV3zrlO1R4iH0ZuR58PSnBoIUmJpWoBcZsc=;
        b=AZyczBzsqBEKqEb1DH+j7E41Xs2fOZciCWjUIb8j9nwfghQjJGS4m5mA4wBDnn0kF+
         Z7TYllG3zNWh5jJnxLzvb8pPE9NST2pYqgKHAB2ZN82Gf5gdNsy+avlSfiks/AfX/5qE
         z7dUKlshiRqsBpRE4BXtaPT6nqqqBFHno9K9zujdy2Oagi2V2XxYWZuu4Xl90vFsObqf
         C0HfjBDjpf+ilUyJGQZMA8ko+65egUZoJkTexkDnQPxaug1hq7onj5dYNWtKF8nJEK+5
         +1aFsoniiWdrSTR/q3jSoK93yZKaZUryXMsXa0y01LaTB+Si4xdTrL6vvsIj/3ytfOdg
         DozA==
X-Gm-Message-State: AOAM530zHK8wS6Q/KuzELhrWCQXR/y6/pvbD5pqrpskgzV5bm5O5fYut
        bH8CstW0nHOBXg0dF+Cp9PqaA0UaAkM=
X-Google-Smtp-Source: ABdhPJzFbMYYW2OXTLOgKEve9eZH3bkc74GqecG00ZgipqvlDKg0mVDs6THChMc4TCgbiwtwWLJrLQ==
X-Received: by 2002:a17:906:94d2:: with SMTP id d18mr16979448ejy.94.1610970583875;
        Mon, 18 Jan 2021 03:49:43 -0800 (PST)
Received: from [192.168.50.4] (iskon6580.duo.carnet.hr. [31.147.121.180])
        by smtp.gmail.com with UTF8SMTPSA id e7sm8530683ejm.115.2021.01.18.03.49.42
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:49:42 -0800 (PST)
From:   Davor Saric <davor.sharic@gmail.com>
Subject: iwlwifi failes to initialize
To:     linux-wireless@vger.kernel.org
Message-ID: <cb81615b-1c6a-8add-ff2a-5533c9620d7a@gmail.com>
Date:   Mon, 18 Jan 2021 12:49:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I am trying to send email with all the details here but its getting 
rejected due to "spam" or html or something. It wrongly interprets the 
content of my email.

My wifi card fails to initialize on power on and it is not related to 
Fast boot. It is happening between linux boots. I am on Arch linux and 
using 5.4 lts kernel. It is the same with recent kernels. I have to 
reset the card with following to make it work.

modprobe -r iwlwifi
echo 1 > /sys/bus/pci/devices/0000\:06\:00.0/reset
modprobe iwlwifi

In dmesg there is an error related:
iwlwifi 0000:06:00.0: enabling device (0000 -> 0002)
iwlwifi: probe of 0000:06:00.0 failed with error -110

Intel(R) Dual Band
Wireless AC 8265, REV=0x230

BIOS of motherboard is latest.

Regards,
Davor
