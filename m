Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D82EE27B1B
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2019 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEWKyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 May 2019 06:54:02 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42704 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbfEWKyB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 May 2019 06:54:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id l25so8571147eda.9
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2019 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=qTOuwOyJ5kax16QmyhEZpO2RfJrLH0eS3Jnk9f5pZzg=;
        b=g4d/bzha5cOTlHh7y0j5vt4itKotewT3N+lu3eUJKSQ0OIGipFAE+PEwkq6sDzq1nl
         Exw0Fo1ryI117KaJye4wBH5F5nmrElQIhFyzuc7gKRBdHUfBT+MqjT1Z+bFpxxwQ+g4P
         XuGsW6HFgmMmZjmoWohpgojAX5nF9lG3PlH9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=qTOuwOyJ5kax16QmyhEZpO2RfJrLH0eS3Jnk9f5pZzg=;
        b=hAf4Cg9Cqlabj3ewWhvXkNwvakOjbOfFt4j7gF7FKTpWCKDUYySAWPsxtpC7uAIRGU
         ZldVyCxJGk2ugBy7qoWuXdrYN5Cp8U5SEKhLsZxKmqiqNWWqm4LTL4GwDlyznBH3RTsb
         TpC4r3lZveIxTy7orh1pcpa5U6ROaUZlriydc5k+R2XFZSTdau9kZ94u//dnjzpZMKyY
         uUkxz5+mjBd69OQyeVRFC5bAGLn0DlELHYo9fXoHpOZ5Gp6lc6kcxuDwmOjl1kWKnAaP
         8K7uQOzakakja3Dk2z2MqeGg880OZugWFLygEXjP7tgpP4IOtULfNNe/Pzn5VBtKLQgp
         Z3sQ==
X-Gm-Message-State: APjAAAVHdsS2f3XhqIls5YU1YdU6zn1G0AvMZsR6JUFLosJiB7IJxAKy
        +m4hTzaCb+HJkzvPna/4bzVtHw+Tfn5Y9g==
X-Google-Smtp-Source: APXvYqw9eE+92BfMiX39/qrzfmV8lkia6qWcx9L2gL15U5O69ZMuE9Bkd7a5kj38Y/U5m6uufK4gvw==
X-Received: by 2002:a17:906:4482:: with SMTP id y2mr69879484ejo.201.1558608840329;
        Thu, 23 May 2019 03:54:00 -0700 (PDT)
Received: from [192.168.178.17] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id q19sm4372358eja.59.2019.05.23.03.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 May 2019 03:53:59 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Date:   Thu, 23 May 2019 12:53:58 +0200
Message-ID: <16ae4537d70.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <871s0pedih.fsf@kamboji.qca.qualcomm.com>
References: <1558008251-13692-1-git-send-email-arend.vanspriel@broadcom.com>
 <1558008251-13692-2-git-send-email-arend.vanspriel@broadcom.com>
 <3dcbfbab-a1f0-bdc6-909a-d9ed225e060a@broadcom.com>
 <f35219bc-88c2-cc8d-530e-516fb7a4ce80@broadcom.com>
 <87mujhoymm.fsf@codeaurora.org>
 <f4d582e8-3d65-959f-78bd-88b7c47131a5@broadcom.com>
 <871s0pedih.fsf@kamboji.qca.qualcomm.com>
User-Agent: AquaMail/1.20.0-1451 (build: 102000001)
Subject: Re: [PATCH 1/7] brcm80211: switch common header files to using SPDX license identifier
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On May 23, 2019 11:17:22 AM Kalle Valo <kvalo@codeaurora.org> wrote:

> Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

>> Or do you want me to resend the whole series without patch 3?
>
> If the series applies without patch 3 (and I assume it does) no need to
> resend the whole series.

Thanks, Kalle

I assume the same.

Regards,
Arend


