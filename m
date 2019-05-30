Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5F612FFE6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfE3QHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 12:07:31 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:42023 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727545AbfE3QHb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 12:07:31 -0400
Received: by mail-ed1-f46.google.com with SMTP id g24so239279eds.9
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2019 09:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=i2nPbU+nIoeqoSXGqz40jeVp0GWIQlSVY/CRlAzcEMo=;
        b=fQ9C0GRrfrP4SSAkVshkxMzhnZyygb2gNrMN+br+diKQGa3BWQ0vcZT7kP5W/HU20G
         xNT9C7E+mYWTaRcxFZW2WKGCFXb+PRZjWS5UIyab9IvDMbLKSVOVD0VCE1Fg5HzP+MHW
         DuKlLD0kWiZaabCYoIekiEQkJXoV2oPp0QIY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=i2nPbU+nIoeqoSXGqz40jeVp0GWIQlSVY/CRlAzcEMo=;
        b=B+U6Mt5su97UJaLNa1Zw/BCFiETVpOmXod7SOsdZOlrl4xBHHDXsQx/IMXViu3ug1S
         7TEKEdlul3C2fuwI97no/i3eMPBbnq1yEAzqVKMjmSEHQpnLMLPEgOWd+C0BKtJoALfO
         i9TiXkDnMwoSAYN3CxU5/4KT1I2HfNJ60FIIhgzkwANx3+Ynf874yLxgmJHKwL08UrQG
         wXVX13pJt3bG3vRkasvSeJlIpgtDkSIH6ZvGF9KlB9afWzOWMhGYpH4bYkOPImicZnaE
         FH1B6rw5Vt41R4cN4My/ARRLTuNVu0n++9tWcpZ4YeWonYxb5yPFfevCmnmOnSRNnT/i
         6Zlg==
X-Gm-Message-State: APjAAAWQfb51blXGGjDsryBbWj/Vl4JrhEw3tFvmWY9hdKq72oeNX2GB
        MitDZPcphWC/qXwj2TE/PFitiq1yMRi+cw==
X-Google-Smtp-Source: APXvYqxBpuhv07WkBUXvJuiC8LUgZL9fXiSUPWhyzUm/sOC+QzPr84CAQU3qZTe5Ms1pY3DqfIXgVw==
X-Received: by 2002:a17:907:10d0:: with SMTP id rv16mr4385579ejb.138.1559232449678;
        Thu, 30 May 2019 09:07:29 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id v16sm822558eds.69.2019.05.30.09.07.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 May 2019 09:07:28 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Jeff Johnson <jjohnson@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Date:   Thu, 30 May 2019 18:07:26 +0200
Message-ID: <16b097efa48.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <d27aac46e682d6cb93ac97df0073818c@codeaurora.org>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558353645-18119-2-git-send-email-arend.vanspriel@broadcom.com>
 <d27aac46e682d6cb93ac97df0073818c@codeaurora.org>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [RFC 1/8] nl80211: add 6GHz band definition to enum nl80211_band
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On May 30, 2019 4:53:13 PM Jeff Johnson <jjohnson@codeaurora.org> wrote:

> On 2019-05-20 05:00, Arend van Spriel wrote:
>> [...snip...]
>>  enum nl80211_band {
>>  	NL80211_BAND_2GHZ,
>>  	NL80211_BAND_5GHZ,
>> +	NL80211_BAND_6GHZ,
>>  	NL80211_BAND_60GHZ,
>> 
>>  	NUM_NL80211_BANDS,
>
> Is it not a concern that this changes the value of NL80211_BAND_60GHZ
> and hence will break any ABI which expects the current value?

Sigh! Obviously that is a concern. Johannes already mentioned it.

Thanks,
Arend


