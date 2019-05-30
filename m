Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BCE3013F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 19:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfE3RwP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 13:52:15 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:46702 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3RwP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 13:52:15 -0400
Received: by mail-ed1-f49.google.com with SMTP id n12so2326947edt.13
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2019 10:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=9pbCm2eYs4Tpvx+HTqshSR3pHIOzgYxl1PLxwBCqpxY=;
        b=fVlDymOdgUDMiyRhrTwDE71VPQhtquvtMq4Pjm63er2J5+fvM5li7b+VPz/NRPHzIj
         gqbOyaSWHxY7kRVHe5az6sazuIGHc7sqTlPOV0uqmC3STQ0B9NLTyYlPwSAz0bFIfy5W
         E3JZqJIX8PAwxVQr3rOxmN1wG88+7+NT4TybI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=9pbCm2eYs4Tpvx+HTqshSR3pHIOzgYxl1PLxwBCqpxY=;
        b=DGDaZgqJWBWHbbSpNET+p1DN+glYA8GEj67VoTuzuTxuWGHN/KojJgYaGqu2dVx4xa
         8FLgoETRJRbu7msESEOvnoIZdLNYcuRZmCI496y3PlsTQrjvWhtWzpFLZINAzeb0YEn/
         c928GHb5uux5Bv7CzgjdJHXp1CLxfgrxc5zyJykbKFU7lse8Hq8s5VaGVdaBCk+sgbyd
         f8zRXS/G+lqsi+oV7kTJMOJKI2HAOKWoAAl8HB7xS1PxvtCeL4R9EbHLArvigmWgEH6p
         soLoTV9Vx9b2rR/79xBha1gKtDIUVSbzESb47NUi0gLxLKjukckB2OadHSbwQLFFPfyh
         nqQg==
X-Gm-Message-State: APjAAAWs0rmDKmyVBB8jSZeGi+a9rcbCuA/gXHH3NJ27CbynIPfEozuQ
        HLrHN+m47Kc8zOpLvyfKNLVsgg==
X-Google-Smtp-Source: APXvYqy746hiCgJhqr9OvqByl46oNSIkZUwnbTGVSeEdl2K07lCbT/OxHE8eYjRt/mhobxXOuzaWyg==
X-Received: by 2002:a17:906:a414:: with SMTP id l20mr4848811ejz.255.1559238733975;
        Thu, 30 May 2019 10:52:13 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id e46sm889348edd.80.2019.05.30.10.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 10:52:13 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Jeff Johnson <jjohnson@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Date:   Thu, 30 May 2019 19:52:12 +0200
Message-ID: <16b09dee4f8.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <284014c56afe555b5fda60a8467f8e6a@codeaurora.org>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558353645-18119-2-git-send-email-arend.vanspriel@broadcom.com>
 <d27aac46e682d6cb93ac97df0073818c@codeaurora.org>
 <16b097efa48.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <284014c56afe555b5fda60a8467f8e6a@codeaurora.org>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [RFC 1/8] nl80211: add 6GHz band definition to enum nl80211_band
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On May 30, 2019 7:43:27 PM Jeff Johnson <jjohnson@codeaurora.org> wrote:

> On 2019-05-30 09:07, Arend Van Spriel wrote:
>> Sigh! Obviously that is a concern. Johannes already mentioned it.
>
> Sorry, overlooked his comment on the [0/8] patch. I'll climb back under
> my rock.

No need to do that. It is mainly me feeling stupid about making such a 
mistake that makes me sigh ;-)

Regards,
Arend


