Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B4035A18F
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhDIO4H (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbhDIO4G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 10:56:06 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77C1C061760
        for <linux-wireless@vger.kernel.org>; Fri,  9 Apr 2021 07:55:53 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so5924654otb.7
        for <linux-wireless@vger.kernel.org>; Fri, 09 Apr 2021 07:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=82VGUtIWtk9RixySaqBS/H8dcEQB5yu4GLi1NcVMktw=;
        b=rtsSTNnxiw2R8+e6zVkwmc29uZgtLmMLN9DCAJ2zzS+ApRofHb2IftDms6YpA/3ve+
         X5IFGzYbbkoC1Pvq3Mch2UGXRPzSfh+Nb7hMC0qV6oCBdhdpPmkwAUl0UJ28iWlDSHNg
         dPLZ5xn86THii6fVchUW5b3UiLvbp+ov9YydM1F3FZcQNMPLmLOR+FjIlZKFngoQHg40
         YXecCYHg5IPuRNUid/GQs6QQ8wpMCksduTqJHHfUra6h1LpO9iMaFU1PbAtvW5TGLinz
         q9uR7TqBUlfH9iXL4GuipvNyBboFiUwrNvxbj6KbEd7h/oWZ0mrNp6GAxp9zD8ByFCqU
         tH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=82VGUtIWtk9RixySaqBS/H8dcEQB5yu4GLi1NcVMktw=;
        b=uBn+nT2e2GXf3CRfV9l1IlPRphFs0wMN8cOr147Bi96Ml7lyffyedxKdLwY6LAoPFg
         B7NkLPx5m8Cz3Xb79yz+A3W2QkFh03ed9EmT0hDEZIenTqdtqHMv1VWqPQBEfEe1oWV3
         YteXqsuAR9NoynZKp9XxpmpNhB6NyLtP8KoYb7+vke4j84eL40x0/+uiHr1zZSD26Hi1
         SGb3zvkEji5Uv/G+NKWQynWntHBwjPYDYptKUGecG/6U0gpz4P4x1vaaEPr7fvZmH37M
         eFUiybgf9hhpBOLUwSCcqYf+ycpKzfgjyN0gQEozUxuMZ8JLeVOI9Smd4f4Yc+zB2xUH
         Y45w==
X-Gm-Message-State: AOAM5334NIbZvViK4puCnD/iwkl/4CaafESQweJRPcj/U6jZB+vGVJjT
        rR2nlqVlVoimRr82ckJ1dkR/7uJwwsI=
X-Google-Smtp-Source: ABdhPJxgGOg+dsM/yPiTLrU14VBqB7dcSrhJycUFQI1LM7MEHdFWXY+0xSQGv7xMAnXWusP45k05tg==
X-Received: by 2002:a9d:7086:: with SMTP id l6mr12407557otj.187.1617980152824;
        Fri, 09 Apr 2021 07:55:52 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id h59sm645061otb.29.2021.04.09.07.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 07:55:52 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Memory leak in rtw88-pci
To:     =?UTF-8?Q?Klaus_M=c3=bcller?= <kmueller@justmail.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <83a9aeff-ce2c-3442-90fa-7e190acf3dfe@lwfinger.net>
 <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <c51e29db-3318-1d17-2dea-be28cb277d57@lwfinger.net>
Date:   Fri, 9 Apr 2021 09:55:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1af1e1f4-caa4-323e-0a2a-b3fdf1cac6b8@justmail.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/8/21 11:12 PM, Klaus Müller wrote:
> 
> May I kindly bring up this reported problem again? Is there anybody working on 
> this problem? Or did I miss the already existing fix?
> 

The Realtek developer suggested an approach that failed. I  have been busy with 
some other high-priority issues, but I will be working on this issue soon.

Larry

