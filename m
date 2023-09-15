Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257E17A2821
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Sep 2023 22:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbjIOUcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Sep 2023 16:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjIOUb7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Sep 2023 16:31:59 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2950106
        for <linux-wireless@vger.kernel.org>; Fri, 15 Sep 2023 13:31:54 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id h8dUqODeEWU1chFTmqTaBy; Fri, 15 Sep 2023 20:31:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id hFTlqaUNBKPGkhFTlqw4QJ; Fri, 15 Sep 2023 20:31:54 +0000
X-Authority-Analysis: v=2.4 cv=Aur9YcxP c=1 sm=1 tr=0 ts=6504bf3a
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=Q-fNiiVtAAAA:8 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=20KFwNOVAAAA:8 a=bUQKSiCPAAAA:8 a=cm27Pg_UAAAA:8 a=HvF037n1xESchLcPDVoA:9
 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22 a=AjGcO6oz07-iQ99wixmX:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=-fHZXUhsFbuwFN3fwQAr:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ue3RszsQVKiUlE896mZUKofmDaDko+ASJefe+MJLC0Q=; b=zqyE1pWntCZDaBefUMJU9F6e4O
        3ocB/BFJ7TRrKApwXODwdmtdZoppldQTL3fwl9BqEXcL52+V27OWeaJZv+KwallnkID4T7CRNYvdF
        kpZ5+SrLArV4itMgovk9o0mnTtliifU+98rM6QMRsylau+quLmDo/TvN3urFTLO7v27QCIvLFVA6S
        pBkCJOZsRTSep7Sg/wD/H1nBdbSOOsRMW1xlP3/n5UdSSXCPeQ5mL9zq+TXd2cGcM80nGDZK3taSm
        7GdbOcS7uENSic8YjYmy9dUZiyVXusnSfncgkNFoKVhEvGHK1ECPZmGyTtK4dBZHYmIEf9GBvQUCo
        sK/8AzzQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:38502 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qhFTk-002NnT-05;
        Fri, 15 Sep 2023 15:31:52 -0500
Message-ID: <dba3cafd-e94d-ff6b-ca49-01467d58170a@embeddedor.com>
Date:   Fri, 15 Sep 2023 14:32:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: brcmfmac: firmware: Annotate struct
 brcmf_fw_request with __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Arend van Spriel <aspriel@gmail.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hector Martin <marcan@marcan.st>,
        =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alsi@bang-olufsen.dk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
References: <20230915200552.never.642-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230915200552.never.642-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qhFTk-002NnT-05
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:38502
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 134
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBzKa1IYGZhOYSmpGf6GwTSLQJhbn7r8QLZGe3zUqoZ3ysD27Sdal/nHVimctT3hwwNY0nPZ88aodp0WzjnARSbSl144ke5+y34SrZPub6hyGdjNFT9Q
 5HRAQbFJkoTivGlIxMbSt9uAr8h4lYUBZDARmpZL/tMtm8h7nVDjghwdow7o74RWDFEeLl375jR3kE6hcey9klQx1YYrBA+XvWD26Q/b4JMqg4CB2sf7opUX
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/15/23 14:05, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct brcmf_fw_request.
> 
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci
> 
> Cc: Arend van Spriel <aspriel@gmail.com>
> Cc: Franky Lin <franky.lin@broadcom.com>
> Cc: Hante Meuleman <hante.meuleman@broadcom.com>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Hector Martin <marcan@marcan.st>
> Cc: "Alvin Šipraga" <alsi@bang-olufsen.dk>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-wireless@vger.kernel.org
> Cc: brcm80211-dev-list.pdl@broadcom.com
> Cc: SHA-cyfmac-dev-list@infineon.com
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-- 
Gustavo

> ---
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> index 1266cbaee072..4002d326fd21 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.h
> @@ -69,7 +69,7 @@ struct brcmf_fw_request {
>   	u16 bus_nr;
>   	u32 n_items;
>   	const char *board_types[BRCMF_FW_MAX_BOARD_TYPES];
> -	struct brcmf_fw_item items[];
> +	struct brcmf_fw_item items[] __counted_by(n_items);
>   };
>   
>   struct brcmf_fw_name {
