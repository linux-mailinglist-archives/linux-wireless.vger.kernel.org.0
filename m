Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26071494B38
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jan 2022 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237931AbiATJ5D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jan 2022 04:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359668AbiATJ4e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jan 2022 04:56:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2774C061748
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jan 2022 01:56:25 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so12293925wmb.5
        for <linux-wireless@vger.kernel.org>; Thu, 20 Jan 2022 01:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THelF9AcHFILg/clSKwtJV+FOl9TlDxqnyg9R3fkuks=;
        b=gj9EarPr4i2QY/tSbMYppi8r3ipjsqWN6b7LdWMAGx9UkwXqTVYzmxUqomznxtIYiw
         InnuSwozro5CecY65IsG32BuCU484pxjHOCr9YXj0jHuWMuDE+tbXoa9XLT7RixzFyIu
         miaCMAGo9yhlZuZIOHJjyA1V8TY5GU1AMtXgOCYFJ69kwKchZl7ICk2bnKRtsi2SB6L9
         khT1Cj8ZHbIqYtIRHcjTGAcD/E5IwEq4G/gAckbxT96XI1nZujauPAFS+XhqeIpDKLIs
         c1nXYZwMLx4en1wD3U0Bi92v683HoxKeh2PRQAyJAj43kAS369Qos9VOuxg6E7bfpn45
         9g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THelF9AcHFILg/clSKwtJV+FOl9TlDxqnyg9R3fkuks=;
        b=xvLcIF1sJ0qt0u5uaE1OpTx8NBBwIzBlpUAlD/vyuGrPxPRleRU9GYMpv/+aRZcxbD
         6YdMynd4XfFJio6MwRn0q6AmJ9CZyqnFC4jKZA3cWchJKcxYleyBRO118gQnbi0zLKXs
         OlWDNxoq/Dc9DwhCYoNflLcVD3gFAE5Grhn3aZP5/6U2pKg0zX7FkS27ZrA6zZcX7zlm
         1iKfszspA7NgwvUfvaRK4RNpF+KJl3lexrS7DTmVzD1F86JzVpcjevT9JLMnfLHPnPr4
         V/Fwhebkd88ZBIfnAQw7u4K2Km6H1w/63/wiU/GRXuETJOEZZWCqc0vxn7wOZm/hO0oL
         h7Rg==
X-Gm-Message-State: AOAM533lsOR+qfFTfAkDFo2+ekQDoFi+qQWLsqsX+z4qUoWtVJ/a6XYB
        AJ2ZvmoHILjhccUQUzTczrflYg==
X-Google-Smtp-Source: ABdhPJyL9QZmwPHpey5LtBNegeYZr+Kxgc93tZ6lJq4WC4G53xuv/D7lv0La0EphGHiB89XfgN2+AQ==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr34911887wrp.89.1642672584382;
        Thu, 20 Jan 2022 01:56:24 -0800 (PST)
Received: from axion.fireburn.co.uk.lan ([2a01:4b00:f40e:900::64c])
        by smtp.gmail.com with ESMTPSA id b15sm2277755wrs.93.2022.01.20.01.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 01:56:23 -0800 (PST)
From:   Mike Lothian <mike@fireburn.co.uk>
To:     khalid@gonehiking.org
Cc:     Deren.Wu@mediatek.com, Eddie.Chen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Eric.Liang@mediatek.com,
        Leon.Yen@mediatek.com, Mark-YW.Chen@mediatek.com,
        Soul.Huang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, YN.Chen@mediatek.com,
        abhishekpandit@google.com, ch.yeh@mediatek.com,
        frankgor@google.com, jemele@google.com, jenhao.yang@mediatek.com,
        jsiuda@google.com, km.lin@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, nbd@nbd.name, posh.sun@mediatek.com,
        robin.chiu@mediatek.com, sean.wang@mediatek.com,
        shawnku@google.com, steve.lee@mediatek.com, ted.huang@mediatek.com
Subject: Re: [PATCH] mt76: mt7921e: fix possible probe failure after reboot
Date:   Thu, 20 Jan 2022 09:56:22 +0000
Message-Id: <20220120095622.1938-1-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
References: <d291f592-d84a-2ffe-7f75-df77890efce8@gonehiking.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

I get a BUG and the kernel resuses to boot with this patch when mt76 is compiled into the kernel

https://bugzilla.kernel.org/show_bug.cgi?id=214557

I don't see this issue when mt76 is compiled as a module

My .config is at https://github.com/FireBurn/KernelStuff/blob/master/dot_config_tip

Let me know if you'd like any more info

Cheers

Mike
