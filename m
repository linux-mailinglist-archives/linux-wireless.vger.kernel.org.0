Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB93254D1A
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgH0SbJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 14:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgH0SbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 14:31:09 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27C3C061264
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 11:31:08 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so5195944otp.12
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 11:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NGm1buXj69OvN8B4nyOtDbHsdlSimkLI+JfsT14cweo=;
        b=DiQ6rpM31ZrKYw/my36d5Y4jDk4ioZD+FQ1qUjnNJH5GG5pKI3mw9MBH3Q/2c4P4zd
         CzW6YYfXu4z6WlYOUrh4X4rCIeLB2VBPFHFG9IHE/HBAstZ3XPRpjoIyJYp7b4toQbfS
         U2G4PtecGXMTX6lrWF7ItXG0vr3Vycg4D90198oKyFaeobmPjCeNTbRMw5KvF83jWYy3
         Iaiwji2t18xi8d8+sz5kyJxIlkkePEDo5o4cvSlu8nfKNM6Vrxurz+ssNFCXu0FF+f+L
         pwXVoR6dtEQ9mAs7+hIUZQMdh2Qp0g10vu9HPWnweKtxLAxNmUAnNLpTYzgB3brRZhdV
         uUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NGm1buXj69OvN8B4nyOtDbHsdlSimkLI+JfsT14cweo=;
        b=L2FHkaEfaW4cqpxK5ttiMHNPRLaldcVpB10KOfhWgwolTMSSkE5Is4omlEaWc4TteI
         ZHfQvCWsSmpa5IJ2QLbKwy0+PjchW/pZ455uc7EnP75dwF9Vg6hs3Yy9enI65kzcf0nJ
         hNd351kGsI5fmTLn2W0bbTpe4QwV1GgmlZostx8C0QHF/rZfoeOItlO5A5pZxNx7CI+c
         v+fDXJ8z6bDFWqLwADZ5g65D+mS6Y9l/KyGHytvcBqrFiAemPr6UhtlWeoQEQpjAY+Od
         CXBrQhbkoWcECGnXCFDnv/byUuCzx0zORK9u40Ayze2H8d29R8bvZLXdc88zRmzDkJM4
         7gxw==
X-Gm-Message-State: AOAM530quRKdck41+3uiRXd60CNsQDgv00VXMhX18zM2IcHjrH7yKg8S
        AOv9wdf/9+PnOTuqdSx4lRBlJ2dywg8=
X-Google-Smtp-Source: ABdhPJwcdCaQyBlUVPiedljuQxX7/knxGYgczFsGqu0SohCI9UYZXH1yqr9ECH3rFdFCrGCcjwQ26A==
X-Received: by 2002:a05:6830:50:: with SMTP id d16mr13510329otp.298.1598553068042;
        Thu, 27 Aug 2020 11:31:08 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v35sm616971otb.32.2020.08.27.11.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 11:31:07 -0700 (PDT)
Subject: Re: [PATCH v2 15/15] rtlwifi: Remove temporary definition of RT_TRACE
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
References: <20200723204244.24457-16-Larry.Finger@lwfinger.net>
 <20200827094217.72A9BC433CB@smtp.codeaurora.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <8cc0d79f-ec95-b7a2-1ac1-c20c06dd62ab@lwfinger.net>
Date:   Thu, 27 Aug 2020 13:31:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200827094217.72A9BC433CB@smtp.codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 8/27/20 4:42 AM, Kalle Valo wrote:
> Larry Finger <Larry.Finger@lwfinger.net> wrote:
> 
>> A definition of this macro was kept until all drivers had been converted.
>> It can now be deleted.
>>
>> This change also renames _rtl_dbg_trace() to _rtl_dbg_out().
>>
>> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: kernel test robot <lkp@intel.com>
> 
> Dropping patch 15 due to the reported build error, please resubmit that
> separately.
> 
> Patch set to Changes Requested.

It turns out that patch 14 is also wrong. Please drop it as well.

Would you prefer just those 2 or a v3 for all 15?

Larry

