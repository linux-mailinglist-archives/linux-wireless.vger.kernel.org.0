Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820E11264AB
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfLSO3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 09:29:22 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33999 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfLSO3W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 09:29:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so5069977edw.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 06:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UhFjAFltYCyzRH3ujc/w8dyQT7TRLcLqXgMDLirCbrc=;
        b=APOsFYGFcBfcpbcrFigIoDmZjytG4oL3oRM4CRE/+k2mKUZBlfwaqB1LGO7oRSOU/G
         580xwWim1HfpGSbZ5zu8HHSkkM9qSKXn8kRHPnX7NJ2FIZgVwj7A/qwoAmaw3u0NhjzA
         i75kxxqtfwVMF1w24L+WZpjHGTvFLQajtyzdSQ3RS5OQL6+W6mmdDIVjozZaP06WGdAr
         U+v2xiUeEEJ1ZRRnZRSeaQAzGn/Ys91pcnwPW57NsUDyHQ8Wyg6MCqs58sPy1qrHIWeB
         1hYyECOPt3rLLS4Zblzi4XVqrxJ500cYc0pv83Y/d6RuIpjgtvwmER42GvBl7qxVE6zQ
         zmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UhFjAFltYCyzRH3ujc/w8dyQT7TRLcLqXgMDLirCbrc=;
        b=LayeIADOScgC2q5E4mRAO9Wd+7t6BNlj8vof+sTHybRs+tAhhGc1Xfcn3tmOFI+Y8I
         bHXl8+Hxd+6yRUuRvmWpe4vSl79T94/d1bPL9CBuZ6euOsi+iPftP7dLx2A23bF1Qpra
         m4kUEsuexDmbLSp9xruIIaFvfpMHs3s6TWN09DBfzjIvlE+gu3cC49qyg6oUJZ4Psx0V
         K14k7UAx8o5/dvhKjcBcT9j0RMWIfBqzjS2+x8fek9IPNgeXMfiBni8AMyho3aamvOqx
         h+LzUfgqGBPaFfeievrZ7y9yeb9VdmEqZ0HX255FGu3BfpM+lG5ziWbO75f4FxeptSBK
         OwEw==
X-Gm-Message-State: APjAAAVgTTAtbi+S8ZIzMkzD6fWcxtshUlHg9sdLuCxJe4DQUsc7lcJ8
        C9Hr46edq/SPlfAUC8Mi9gJOWOtgUUQ=
X-Google-Smtp-Source: APXvYqyZPWOkOSnAhj5sr6bTr+m3mp50ealr0bgqj0CgCijIhawAly+6PZWhzDUUsYa95M3r/ZNm7g==
X-Received: by 2002:a50:b8e2:: with SMTP id l89mr9486539ede.245.1576765760010;
        Thu, 19 Dec 2019 06:29:20 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id j17sm390080ejf.83.2019.12.19.06.29.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 06:29:19 -0800 (PST)
Subject: Re: [PATCH 1/2] ath10k: pci: Only dump ATH10K_MEM_REGION_TYPE_IOREG
 when safe
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     akolli@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org
References: <20191219131539.1003793-1-bryan.odonoghue@linaro.org>
 <20191219131539.1003793-2-bryan.odonoghue@linaro.org>
 <87woas5slt.fsf@kamboji.qca.qualcomm.com>
 <38bf1f75-0554-920a-0f29-354e70cfc077@linaro.org>
 <87sglg5rb0.fsf@kamboji.qca.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <4a8b7913-c9b9-dd67-124d-b4f71747c849@linaro.org>
Date:   Thu, 19 Dec 2019 14:29:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <87sglg5rb0.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/12/2019 14:21, Kalle Valo wrote:
> 'dmesg | grep ath10k' should show it.


[    6.579772] ath10k_pci 0000:01:00.0: firmware ver 10.4-3.9.0.2-00044 
api 5 features 
no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps crc32 
c3e1b393

