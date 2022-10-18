Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D5D60350D
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Oct 2022 23:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiJRVji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Oct 2022 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJRVjg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Oct 2022 17:39:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23CF15A36
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 14:39:34 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so15078174pls.9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Oct 2022 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1c75cTWpMkVM2S4MpmZ6QJWntZq6eJiJQNy1LPr0zWM=;
        b=ng1w3eqzuPXaZ+0Q845NjYCJb3wPl+3qR/Nz20eEY9M5JqzVcw7YykVCKkFGev45Mj
         YFZkJiwdZoZJJKDouDc1Zy4s6wbSy0gwrWzgBZ4Ng/usOBWG9E6jb2Wl4zNEITXyAi6a
         dXxaXVzm49lCVnOb++BlrvMk2R6fsCEHqMr46JXW2bI8diMUrXdLyiy/p+y6SHy8Kzet
         yjZkVeCVBBn5qokd6FsFnOGHT4fSme3zYUavOV/VAKBYhBCIfzbWCIXfu4CYV8ruc43T
         zrXXYYV5DzxFPOm6tF36kjTNhdHW+N4GmSvrzlp4rQbCC5CPYMr/iqVcCZCvGz9mpZUW
         NcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1c75cTWpMkVM2S4MpmZ6QJWntZq6eJiJQNy1LPr0zWM=;
        b=BDTsi9l/L4VreILBg8XPgwwWeuf/rphloFdib7bnRohFcT66emXAAA39LB1jfYH2eE
         aSxr9EhtWlNsADQQMRbUXQ2sIksV383KAuAjEEB6XGRvpgxXQohgNO1iEo6wH9waHHDg
         JbVvIcFM5Io770fOtaEeR5ZlSBfUdyNOhV/Z4CS7iWP1gQ9Q7YiSYgdiFMId20D+RPna
         SBVgCAUwWlJXQkWlqXjTp92pd6XQp8v4CU8XZxIh8mjNgQDoNPAVQ3lx7anUF5qneOTq
         31RMLz3P9EMyY6Mo8ajV4OH4V3KPmx1ZVlFUa+wVnwKhDQ/bsHCACvHxTEiB9//bU4pb
         PTzA==
X-Gm-Message-State: ACrzQf1ASg59DzqXwiK/oy8Xexk+pKRWIY/KpCzVYzwNEo8zAhLyul7n
        I8xs9mYyHwKU1QqQyoiAFPZ7HNFEXpQ=
X-Google-Smtp-Source: AMsMyM4fsZxqzvAljVlTjOmS5OcLzri2biMjsL+RBizLeBABMSotUMegdUDp1VGw4bwbA1mnXlIcKw==
X-Received: by 2002:a17:903:4ca:b0:179:d21f:f04b with SMTP id jm10-20020a17090304ca00b00179d21ff04bmr5019087plb.7.1666129174117;
        Tue, 18 Oct 2022 14:39:34 -0700 (PDT)
Received: from [192.168.254.15] ([50.39.160.234])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090322c400b0017f75654a33sm9170257plg.73.2022.10.18.14.39.33
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:39:33 -0700 (PDT)
Message-ID: <1bb6a89fb1401887f90c65af163cabc4a9d80ce9.camel@gmail.com>
Subject: iwlwifi connection loss leading to unknown state
From:   James Prestwood <prestwoj@gmail.com>
To:     linux-wireless@vger.kernel.org
Date:   Tue, 18 Oct 2022 14:39:33 -0700
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

A user reported IWD being hung after attempting to reassociate. We have
tracked this down to iwlwifi timing out during/before association
("connection_loss") but the path back into mac80211 never results in a
disconnect event. After CMD_CONNECT (reassociate) we get a successful
authenticate event but then nothing (besides DEL_STATION). No connect
event indicating an error which is unexpected for IWD so it just hangs
waiting for _something_ (disconnect, connect event, associate event
etc).

We see the following messages when this happens:

[503620.270833] iwlwifi 0000:00:14.3: Not associated and the session
protection is over already...
[503620.270943] wlan0: Connection to AP d0:15:a6:70:b5:40 lost

This tells us that ieee80211_beacon_connection_loss_work() was called,
and in turn __ieee80211_disconnect(). The problem is we aren't yet
associated, so we bail out with:

__ieee80211_disconnect():
	if (!ifmgd->associated) {
		sdata_unlock(sdata);
		return;
	}

I believe we should be sending a disconnect event here? or a connect
event? or something to tell userspace what happened?

Like something in ieee80211_rx_mgmt_deauth() where ifmgd->assoc_data is
checked for indicating association was started but not completed and
send out a disconnect event right?

Note: I would also guess that ifmgd->assoc_data is being leaked when
this happens since I see no path to free it.

Thanks,
James

