Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7CEF2E2889
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Dec 2020 19:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgLXSTW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Dec 2020 13:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728266AbgLXSTW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Dec 2020 13:19:22 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36714C0613C1
        for <linux-wireless@vger.kernel.org>; Thu, 24 Dec 2020 10:18:42 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id d203so3065348oia.0
        for <linux-wireless@vger.kernel.org>; Thu, 24 Dec 2020 10:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jyD6CT++WZwx70gtUs8s+TXH84BNusNmsPhJwod/hBo=;
        b=NF14KycKfD5QJky+E3toTspo5+hbfBc1wmm5lieP7ZfuiIKVqu59PpW6FcKe9IcDRA
         asMjayYNHxOdB6Psi69jTRq0g665i0rDb66Z5y0GUvnqroVhTDrM3k/GOPpxAlBQn/+f
         tPFwU0zBksfjLgeeqhw1CGU7WbrRTQJDdwWvm/bcr6FMb5MfhKBEZM7XaMFiZ5E9Mr5r
         zqmCjds0JhYtPGCQqaTfhg/X8EjTcvjVYZap/i5GutZlpMPoXBuoZSlZRK+7gvPRTB8e
         teh1gsdLYm1WhukUE0jl69T7rgksAlK2Zh2Fz/OgHExAyp0mmBGKez9tfdp7R/wFYUuo
         Fnsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jyD6CT++WZwx70gtUs8s+TXH84BNusNmsPhJwod/hBo=;
        b=dESKOCRrgQr/TqyPrc6ocZ5mn969oeI2XTJJzANl8UMkxwYKqARYIcdaNS1nK+vNnn
         sZyXV/OqdCF6YdzT2X3RSJMYLsRtZ3IfYNk1IyjvxTyBIPbktqPPemYDNgI7Rt0x/vpY
         8k0BfWFjEgbNlFFheLBm3nD2L10EJWDGES55KrWF47DvgMVxhjNuaK70ZsWnmoH/z6PG
         d6X9YvX/eoNYk7ZIEf+6x4zXeOgQazzGRdPOGkmI27n4G525VVLUh5VZpdVOJf9JVbEL
         +k31m/p+lMmuEAHZixOFaZovtUiECEEnTc2P6TnFyFkEnsUrtbsZV100jbj+3aZvfcSm
         0lYQ==
X-Gm-Message-State: AOAM530ibHLRxPCuxnaIcxnoNNxeL7lkWYhjWy982AWCaqTMIkl5JOJo
        QP60sM6c2gqSgrGFlyW4F456i+6jOP0=
X-Google-Smtp-Source: ABdhPJwIzCpOzQkGCHM+C9EfrZxHBhxtJCMnk8B2c+Rp6W1UDHd6dFBUG6nPBziyDxBx3qlBbxP2pQ==
X-Received: by 2002:aca:7544:: with SMTP id q65mr3613874oic.51.1608833921690;
        Thu, 24 Dec 2020 10:18:41 -0800 (PST)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id o21sm6974648otj.1.2020.12.24.10.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Dec 2020 10:18:40 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: 802.11ac AP mode support on Realtek 8821AE?
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Pkshih <pkshih@realtek.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ethan Hsieh <ethan.hsieh@canonical.com>,
        Hugh Chao <hugh.chao@canonical.com>
References: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <e90f1953-cda0-baf7-1b5c-56c649df6b90@lwfinger.net>
Date:   Thu, 24 Dec 2020 12:18:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAAd53p7oymvge7DZ1_+7aA45EpNjG=FZ3PNJDv=_UT0ghv+rqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 12/24/20 7:26 AM, Kai-Heng Feng wrote:
> Hi Ping-Ke,
> 
> We've found that when creating 5G AP on 8821AE, it's not on other
> devices' wifi list.
> 
> Here's the steps I used to create an AP:
> $ nmcli c add type wifi ifname wlp3s0 con-name hello autoconnect no ssid hello
> $ nmcli c modify hello 802-11-wireless.mode ap ipv4.method shared
> 802-11-wireless.band a
> $ nmcli connection up hello
> 
> If we change "802-11-wireless.band" to "bg", then the AP can be
> scanned by other devices.
> Does 8821AE have hardware capability to support 5G AP?

What does 'iw list' show for 5G frequencies?

Larry
