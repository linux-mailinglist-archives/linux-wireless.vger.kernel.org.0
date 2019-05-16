Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E06D520FCA
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2019 22:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfEPU5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 May 2019 16:57:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38631 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfEPU5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 May 2019 16:57:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id w11so7160435edl.5
        for <linux-wireless@vger.kernel.org>; Thu, 16 May 2019 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4XRNMyEkvaaS1Z60Jwn1Q6UuSoDUMF44bfh/UfU+GCY=;
        b=dhxit1wfwozYhjzH6SAWanqrrwgPaKLye1ic2qqQdtnhlVKVLY/hlSjU14n1/3yzcL
         zIv6JZyNIsdtglyZZlzF21m1zR3Iz8RbITFOcrzGgtftS+YR6+GJxBWb+xh64ndhBGsw
         NGo5qRcGbakCjNYXVknUWylathuFxlqP00xos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XRNMyEkvaaS1Z60Jwn1Q6UuSoDUMF44bfh/UfU+GCY=;
        b=c3LC0aKSPK475ywuru7XgVk/Req7+7s5JB65+D0wwfxdLWLsxlcv40e5TiaydupXL4
         +VppemB5cfH/nfnUnTOxCTuUsge1nnvcbqSH4axHexto1zM3/nkttZ09/PIvg4ptkKnN
         9qeLlkIHc7Ldun6f52Is7Qc6CDXoV3S+/4qPPcB+75a2Y45WucEHgU9fO7QXMhx8OI4P
         n7DyIzOZm6WWOzqci5qtN+DbnRz+ArODeZKxI3Z2cB0Pfzt/R0B9em8YjjtCw/gNjUdw
         FxKL7ooKF+wlupJPLJW4zvGJkhRfkhGKTUAm8w//4AYWiF/vFd5LYL9p3Ov841KRI056
         fA3Q==
X-Gm-Message-State: APjAAAVNeqtTM1kwYFpHCj3OP2sx9n/Y2TkYSUG2U/cLiqeIUbkHtFgT
        tCHPrQE1W9wH9m0cnhgTIPDCKDwAv1NLeuTr07mlu4Z5AcIMVTDfGxrbxZpvEEVjz5ew28Qs1gh
        1kY1aO9w3dNX6U7i2XJVKv04RWF4TUi8PtGUbhibkkgkGG/RaQD1FbE7HffpQ2mzoK0VPVZIFQL
        Qk58vVIZY6uhuQAw==
X-Google-Smtp-Source: APXvYqyIsRNVunziKDJ60b3LdWLfgiyu3LIQDPFPeo/lqY3ewZdmwVU37wUcxSZLq0qY5V4JjHLrtQ==
X-Received: by 2002:a50:9016:: with SMTP id b22mr51031168eda.99.1558040264059;
        Thu, 16 May 2019 13:57:44 -0700 (PDT)
Received: from [10.230.33.15] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id d24sm1219752ejt.12.2019.05.16.13.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 13:57:43 -0700 (PDT)
Subject: Re: [PATCH 1/7] brcm80211: switch common header files to using SPDX
 license identifier
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <3dcbfbab-a1f0-bdc6-909a-d9ed225e060a@broadcom.com>
Date:   Thu, 16 May 2019 22:57:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/16/2019 2:04 PM, Arend van Spriel wrote:
> With ISC license text in place under the LICENSES folder switch
> to using the SPDX license identifier to refer to the ISC license.

Hi Kalle,

Given the feedback on checkpatch (or spdxcheck) failures let me respin 
this series.

Gr. AvS
