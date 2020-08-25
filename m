Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839CC2511EE
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 08:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgHYGP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 02:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHYGP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 02:15:57 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDD9C061574
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 23:15:57 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r13so9464436iln.0
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 23:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=uAD/ydHflsHBI+MpzNDORMixj6+tGLaibqxSoOUvTwM=;
        b=Kl3lbNpqicHmnkTqw7uyu2O9N5R85wYsmjbkkF040GeWXZ61GdlQftAZpWprVXfezb
         wJJNVBhybsD/+ggEMHFzbDUuYBfe183H+3+gKFvzC/HfO22hTRw39bhzlekjWVHRzZE/
         hYEvSC6+jaEfaCnQzpoj7hq+57KmROxRkA/5C0NCzMb0/TBb3oJ2k1yP8xBQ+fAnDySZ
         ElypPdTLBBzI55KLo3SROivipynpf75+uz+w5lSuZmTeAUSyIO+wX7SRpVCBN64g4NHu
         iQFLaaPEeOkovwAUxoCdWnLYJhOhlKweeWyRR5hKbXvDW0+ItuPd/wdLQifSXoCgf+Gh
         e8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=uAD/ydHflsHBI+MpzNDORMixj6+tGLaibqxSoOUvTwM=;
        b=C6fAvAnlYgIT4P3reoumWtVtakmeeMtRHJGfUu1J1DKbAlv82vBm+k765LWQqq9G+A
         9WStIYy5Hc5dC1tzQl6GAnsdNziTPpEiKGujS0M+65oYCImLEA5Ve8kx/UKG0f9ePhk9
         lzJTu3FVGCbWR7WmcpRLdICNvPcOnJdZbZF1kC/BS0opiROlZYm5SxVQRlo99MqKfsoZ
         7wpnLHpnuXZHyGqtXYY9zrg6PfbrlnBU4MxTtuIw0N1OOdTq/qO0qxBZDpOzMUgrrhXJ
         FExe2mTjTAHLqijZ1WrFvurnVoMLEptX7lct2gcQThxG4avJMzIYwAN6A6OaVAY2S0E9
         d9uw==
X-Gm-Message-State: AOAM531Ws0Q5hYH4aNHMjBQr9JO9B69fZ0oRuBE9xgmJx8Cb0ZUFxgT9
        fRWMYrtGdMnZXzO+b21UPPFhFx2vxoRNdQ==
X-Google-Smtp-Source: ABdhPJzPiMlzbGhAOEPxfzoFoxmfIhxsXPC5nKa67TCJXbMXU6qxNHAQjv8PYnqxtCcsnadcQtJFqA==
X-Received: by 2002:a92:d4cf:: with SMTP id o15mr6999075ilm.160.1598336156385;
        Mon, 24 Aug 2020 23:15:56 -0700 (PDT)
Received: from [192.168.42.220] ([104.243.234.151])
        by smtp.gmail.com with ESMTPSA id v16sm8510542ilq.84.2020.08.24.23.15.55
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 23:15:56 -0700 (PDT)
To:     linux-wireless@vger.kernel.org
From:   isaac reemtsma <isaacjohnr22@gmail.com>
Subject: Apparent poor reception of WiFi on rtl8821ce, especially 2.4g WiFi.
Message-ID: <aebff74a-2621-ffef-857c-9aca7690cdc1@gmail.com>
Date:   Tue, 25 Aug 2020 01:15:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I have tried this driver as presented in lwfinger's repository 
(https://github.com/lwfinger/rtw88.) The distribution I use is Arch 
Linux. Please follow up with any further requests for needed 
information, as I am new to this

