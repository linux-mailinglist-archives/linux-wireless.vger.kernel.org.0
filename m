Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0F1E1CF5
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 10:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgEZIKm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 04:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgEZIKm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 04:10:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE73EC03E97E
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 01:10:41 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so2770347wro.1
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8CiUfAKcx41BKeIFSJPTHVkR7fQx5ft6sh2tU1Ep9vI=;
        b=Ns+IkjqdGJ7Hoa2QF1dWzZyV0wDf/c6AvGZ7/o+B41UXo/8ZTZ8SJtwiMv8cIhp8HR
         tRD70z3gQvNM924ZiKYNSNglp1HS6bk4Dw+Je9jH1E/tsAO/9zXd5Ti6qgM0ArqGxwQV
         8gtEj3AKScYthWbtUyIPVJQvUKvYvvEG7xFQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8CiUfAKcx41BKeIFSJPTHVkR7fQx5ft6sh2tU1Ep9vI=;
        b=UORvNIkt9sG71snZAQ9Y2BGG/14UdNcWbOmy7vfYUsUb2aeV4ezEUEgV7fsHfaEGBe
         MbzmQWOLwFTWMKxhOWyYt++eD1XBHZ6eRCPQpDJ2WQLwj35LPD2NR+S2i4bdCzSZAtZF
         7gj2ftQ7E3t/iufmVOTaD83eUsV/gMFBIZVEbItbOmwTpxC8sF/dVQ92YKSMZ3Rb9mph
         vPg2EraBMte8W2/0XHB67qfT4KlmYLWCaah1hwpG0a1BGYfBpjHk+qB+/p5CqQ5sqLo8
         UEDj3MZW7uJKlJoG9H+hnxOWAqvMGykyk0ncfQlDGT/m8r2PEQ9+qz3GMvx5qgIf/XwM
         WYnA==
X-Gm-Message-State: AOAM531JIx3oPeg5RSa9FVipYwe3Z0G6ix8ajDWDRHh3yFgzfBnlAq4e
        d1CRF0QJFpUCoT6nbewYHPz90eLgWjRHRKTr5nUpPwPrfDxkbKnDjK4KybfaZzFYxdktcBBgyST
        S6YmM8J6eVrFou7VEYRfcScavzU4ttBDzPj82fYcZ1ASam1RdqZWMMXCcJtIOUg5YDHcO4uZf7h
        Mz7lxa1gpeqzcpWUdA
X-Google-Smtp-Source: ABdhPJxmtTUBftj//DB7nNtCi64JKApEPK0/e3lLiHwqmhIeligH/YrN0LDWr2XzPdPUH5UGD+hjxQ==
X-Received: by 2002:a5d:628c:: with SMTP id k12mr11254061wru.211.1590480638478;
        Tue, 26 May 2020 01:10:38 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id p10sm21504395wra.78.2020.05.26.01.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 01:10:37 -0700 (PDT)
Subject: Re: [PATCH] cfg80211: propagate iftype HE 6 GHz capability
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
References: <1590467491-21187-1-git-send-email-rmanohar@codeaurora.org>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <8cf15557-2400-0893-9846-f091df7bc457@broadcom.com>
Date:   Tue, 26 May 2020 10:10:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590467491-21187-1-git-send-email-rmanohar@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/26/2020 6:31 AM, Rajkumar Manoharan wrote:
> Advertise per interface HE 6 GHz band capability to user space
> which will be used to build IEs.

I am missing the bigger picture here. It should really be determined by 
the band in which the interface type is operating, right? Can you refer 
to patches on the hostap mailing list relying on this one?

Regards,
Arend
