Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2EB1A80D
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 16:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbfEKOAo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 10:00:44 -0400
Received: from nbd.name ([46.4.11.11]:57120 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbfEKOAo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 10:00:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9XuCHkqZm6RJ5XeNwlulvaLKXxnZIENevXtLcjNMIOg=; b=hFmX952W1otROjDjklawndU8U9
        +jRmP+2sufW0VHCMsqzzPMCDlwOcznXgjvT50qohFNyZPB95++P9/25BrVkXtEDKvJMYSG4dAxW3t
        /J2JQMV4eSzmhjtS3J5qHwsTnmuN+xdAufIBx+eBZBDDyO0cUObuVzTIE9MuTggP9Orw=;
Received: from p54ae9c89.dip0.t-ipconnect.de ([84.174.156.137] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hPSYI-0004EH-IU; Sat, 11 May 2019 16:00:38 +0200
Subject: Re: [PATCH 00/17] use standard signature for mt7615 mcu api
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
References: <cover.1556981521.git.lorenzo@kernel.org>
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
Message-ID: <f937d234-13e6-75b7-c00d-c07f2b108027@nbd.name>
Date:   Sat, 11 May 2019 16:00:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <cover.1556981521.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-04 17:28, Lorenzo Bianconi wrote:
> Introduce mt76_mcu_ops data structure in mt7615 mcu code in order
> to reuse the code with other bus types and unify the code with mt7603
> driver
> 
> Changes since RFC:
> - rebase ontop of https://patchwork.kernel.org/patch/10928753/
> - fix net_type initialization in mt7615_mcu_set_bss_info
> 
> Lorenzo Bianconi (17):
>   mt7615: mcu: simplify __mt7615_mcu_set_wtbl
>   mt7615: mcu: simplify __mt7615_mcu_set_sta_rec
>   mt7615: mcu: remove bss_info_convert_vif_type routine
>   mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl_bmc
>   mt7615: mcu: use proper msg size in mt7615_mcu_add_wtbl
>   mt7615: mcu: unify mt7615_mcu_add_wtbl_bmc and mt7615_mcu_del_wtbl_bmc
>   mt7615: mcu: remove unused parameter in mt7615_mcu_del_wtbl
>   mt7615: remove query from mt7615_mcu_msg_send signature
>   mt7615: remove dest from mt7615_mcu_msg_send signature
>   mt7615: mcu: remove skb_ret from mt7615_mcu_msg_send
>   mt7615: mcu: unify __mt7615_mcu_set_dev_info and
>     mt7615_mcu_set_dev_info
>   mt7615: mcu: do not use function pointers whenever possible
>   mt7615: mcu: remove unused structure in mcu.h
>   mt7615: mcu: use standard signature for mt7615_mcu_msg_send
>   mt7615: initialize mt76_mcu_ops data structure
>   mt7615: mcu: init mcu_restart function pointer
>   mt7615: mcu: run __mt76_mcu_send_msg in mt7615_mcu_send_firmware
Applied (including updated patch 12/17), thanks.

- Felix
