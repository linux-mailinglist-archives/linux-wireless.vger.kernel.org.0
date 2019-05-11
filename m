Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C58A81A7EC
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 15:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbfEKNWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 09:22:16 -0400
Received: from nbd.name ([46.4.11.11]:54510 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbfEKNWP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 09:22:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CsUg0o9elKqeGIVUFKfRK8gOuxXmcrUeY+Z813r4Xr4=; b=sDR/ctZrRtomBWeTrV6PErDXvW
        soggBIpTPiSjmiTpgZb+viuAH48RSfge0k8BC+klA2ktbcZOdx+sZ4zGQGgNhbyp0KE16a3hKgPdx
        DDo2H0Be6nTFVgEC2TIh3R/dROCXqJDgSBI6h/n6DnwWTViUacWjhc2PMHdnhEtTBm5Y=;
Received: from p54ae9c89.dip0.t-ipconnect.de ([84.174.156.137] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hPRx7-0001I9-0D; Sat, 11 May 2019 15:22:13 +0200
Subject: Re: [PATCH] mt76: mt76x02: remove useless return in
 mt76x02_resync_beacon_timer
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
References: <cover.1556717431.git.lorenzo@kernel.org>
 <b6e845207d947ce62161d98ea79a011211709062.1556717431.git.lorenzo@kernel.org>
From:   Felix Fietkau <nbd@nbd.name>
Openpgp: preference=signencrypt
Autocrypt: addr=nbd@nbd.name; prefer-encrypt=mutual; keydata=
 mQGiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwbQcRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPohgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQuQINBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabiEkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCfTKx80VvCR/PvsUlrvdOLsIgeRGAAn1ee
 RjMaxwtSdaCKMw3j33ZbsWS4
Message-ID: <a9bb9211-20dc-697e-6956-27693f8769a8@nbd.name>
Date:   Sat, 11 May 2019 15:22:12 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b6e845207d947ce62161d98ea79a011211709062.1556717431.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-01 15:44, Lorenzo Bianconi wrote:
> Remove useless return statment in mt76x02_resync_beacon_timer routine
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied, thanks.

- Felix
